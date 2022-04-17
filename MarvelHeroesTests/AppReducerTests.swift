import Combine
import ComposableArchitecture
import Foundation
import XCTest
@testable import MarvelHeroes
@testable import Feature_Heroes
@testable import Feature_HeroDetails

class AppReducerTest: XCTestCase {
    
    func test_navigateToHeroDetails_shouldChangeHeroDetailsState() {
        let anyData: Data = .init()
        let heroCellData: HeroCellData = .init(id: 0, name: "mock", thumbnail: anyData)
        let environment: AppEnvironment = .init(
            heroesEnvironment: .failing,
            heroDetailsEnvironment: .failing
        )

        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: environment
        )

        store.send(.heroes(.navigateToHeroDetails(heroCellData: heroCellData))) {
            $0.heroDetailsState = .init(
                title: heroCellData.name,
                description: heroCellData.description,
                imageData: heroCellData.thumbnail,
                characterId: heroCellData.id
            )
        }
    }
    
    func test_setNavigation_whenIsNotActive_shouldSetToNillHeroDetailsState() {
        
        let initialHeroDetailState: HeroDetailsState = .init(
            title: "Name",
            description: "Description",
            imageData: .init(),
            characterId: 123
        )
        
        let environment: AppEnvironment = .init(
            heroesEnvironment: .failing,
            heroDetailsEnvironment: .failing
        )

        let store = TestStore(
            initialState: AppState(heroState: .init(), heroDetailsState: initialHeroDetailState),
            reducer: appReducer,
            environment: environment
        )

        store.send(.heroes(.setNavigation(isActive: false))) {
            $0.heroDetailsState = nil
        }
    }
}

extension HeroesEnvironment {
    static let failing: Self = .init(marvelCharactersLoader: { _ in
        XCTFail("\(Self.self) is unimplemented.")
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }, loadThumbnail: { _ in
        XCTFail("\(Self.self) is unimplemented.")
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }, loadMarvelCharacters: { _ in
        XCTFail("\(Self.self) is unimplemented.")
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }, mainQueue: .failing)
}

extension HeroDetailsEnvironment {
    static let failing: Self = .init(loadCharacterDetails: { _ in
        XCTFail("\(Self.self) is unimplemented.")
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }, mainQueue: .failing)
}
