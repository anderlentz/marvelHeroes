import CoreUtils
import Combine
import ComposableArchitecture
import XCTest
@testable import Feature_HeroDetails

final class HeroDetailsTests: XCTestCase {
        
    func test_loadDetails_onSuccess() {
        
        let characterDetails: CharacterDetails = .init(comics: ["Comic 1"], series: ["Serie 1"], stories: ["Story 1"])
        let environment: HeroDetailsEnvironment = .init(
            loadCharacterDetails: { id in
                .complete(with: .success(characterDetails))
            },
            mainQueue: .immediate.eraseToAnyScheduler()
        )

        let store = TestStore(
            initialState: HeroDetailsState.dummy,
            reducer: heroDetailsReducer,
            environment: environment
        )

        store.send(.loadDetails)
        store.receive(.receiveDetails(.success(characterDetails))) {
            $0.isLoading = false
            $0.heroDetails = characterDetails
        }
    }
    
    func test_loadDetails_onFailure() {
        
        let error = NSError(domain: "Mock Error", code: 0)
        let expectedCommonError = CommonErrors(error)
        let environment: HeroDetailsEnvironment = .init(
            loadCharacterDetails: { id in
                .complete(with: .failure(error))
            },
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        
        let store = TestStore(
            initialState: HeroDetailsState.dummy,
            reducer: heroDetailsReducer,
            environment: environment
        )

        store.send(.loadDetails)
        store.receive(.receiveDetails(.failure(expectedCommonError))) {
            $0.isLoading = false
        }
    }
    
    func test_didSelectSegment() {
        let environment: HeroDetailsEnvironment = .failing
        
        let store = TestStore(
            initialState: HeroDetailsState.dummy,
            reducer: heroDetailsReducer,
            environment: environment
        )

        store.send(.didSelect(segment: .comics)) {
            $0.selectedSegment = .comics
        }
        
        store.send(.didSelect(segment: .series)) {
            $0.selectedSegment = .series
        }
        
        store.send(.didSelect(segment: .stories)) {
            $0.selectedSegment = .stories
        }
    }
    
}

extension HeroDetailsEnvironment {
    static let failing: Self = .init(
        loadCharacterDetails: { _ in
            XCTFail("\(Self.self) is unimplemented.")
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        },
        mainQueue: .failing
    )
}

extension HeroDetailsState {
    static let dummy: Self = .init(title: "", description: "", imageData: .dummy, characterId: 0)
}

extension Data {
    static let dummy: Data = Data("".utf8)
}


extension AnyPublisher where Output == CharacterDetails, Failure == Error {
    
    static func complete(with result: Result<CharacterDetails, Error>) -> Self {
        
        switch result {
        case let .success(details):
            return Just(details)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        
        case let .failure(error):
            return Fail(
                outputType: Output.self,
                failure: error
            )
                .eraseToAnyPublisher()
        }
    }
}
