import Combine
import ComposableArchitecture
import XCTest
@testable import HeroesFeature
import StoreKit

final class HeroFeatureTests: XCTestCase {
    
    var scheduler: TestSchedulerOf<DispatchQueue>!
    
    func test_viewDidLoad_shouldCallMarvelCharactersLoader() {
        let scheduler = DispatchQueue.test.eraseToAnyScheduler()
        var didCallMarvelCharactersLoader = false
        let spyEnvironment = HeroesEnvironment(
            marvelCharactersLoader: {
                didCallMarvelCharactersLoader = true
                return .success()
            },
            loadThumbnail: { _ in .success()},
            mainQueue: scheduler
        )
        let store: Store<HoroesViewState, HeroesViewAction> = .init(
            initialState: HoroesViewState(),
            reducer: heroesReducer,
            environment: spyEnvironment
        )
        let sut = HeroesViewController(store: store)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(didCallMarvelCharactersLoader)
    }
    
    func test_marvelCharactersLoader_onSucessWithEmptyResult_happyPath() {
        let emptyCharactersResult: [MarvelCharacter] = []
        let environment = HeroesEnvironment(
            marvelCharactersLoader: { .success(result: emptyCharactersResult) },
            loadThumbnail: { _ in .success()},
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        let store = TestStore(
            initialState: HoroesViewState(),
            reducer: heroesReducer,
            environment: environment
        )
      
        
        store.send(.load)
        store.receive(.receiveCharacters(.success(emptyCharactersResult)))
        store.receive(.loadThumbnail(characters: emptyCharactersResult))
        
    }
    
    func test_load_withNonEmptyCharactersAndTumbnails_shouldShowCharacters() {
        
        let character1: MarvelCharacter = .mock(id: 1, name: "char1", description: "some description for 1", thumbnailURL: "http://any-url/1.jpg")
        let anyThumbnailImage = UIColor.red.image()
        let anyThumbnailImageData = anyThumbnailImage.pngData()!
        let charactersResult = [character1]
        let expectedCellData = HeroCellData(id: character1.id, name: character1.name, thumbnail: anyThumbnailImageData)
        
        let environment = HeroesEnvironment(
            marvelCharactersLoader: { .success(result: charactersResult) },
            loadThumbnail: { _ in
                return .success(data: anyThumbnailImageData)
            }, mainQueue: .immediate.eraseToAnyScheduler()
        )
        let store = TestStore(
            initialState: HoroesViewState(),
            reducer: heroesReducer,
            environment: environment
        )
      
        store.send(.load)
        store.receive(.receiveCharacters(.success(charactersResult)))
        store.receive(.loadThumbnail(characters: charactersResult))
        store.receive(.show(cell: expectedCellData)) {
            $0.heroCellsData = [expectedCellData]
        }
        
    }
    
    func test_loadCharacters_withError_shoulFailureWithoutLoadingThumbnail() {
        
        var didCallLoadThumbnail = false
        
        let mockError = NSError(domain: "MOCK", code: 0)
        let environment = HeroesEnvironment(
            marvelCharactersLoader: { .failure(error: mockError) },
            loadThumbnail: { _ in
                didCallLoadThumbnail = true
                return .success()
            },
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        let store = TestStore(
            initialState: HoroesViewState(),
            reducer: heroesReducer,
            environment: environment
        )
        
        store.send(.load)
        store.receive(.receiveCharacters(.failure( CommonErrors(mockError))))
        
        XCTAssertFalse(didCallLoadThumbnail)

    }
    
}
