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
        let expectedCellData = HeroCellData(id: character1.id, name: character1.name, thumbnail: anyThumbnailImageData, description: character1.description)
        
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
    
    func test_search_withEmptyName_shouldNotCallLoaders() {
        
        var didCallMarvelCharactersLoader = false
        var didCallLoadThumbnail = false
        
        let environment = HeroesEnvironment(
            marvelCharactersLoader: {
                didCallMarvelCharactersLoader = true
                return .success()
            },
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
        
        store.send(.searchCharacter(name: ""))
        
        XCTAssertFalse(didCallMarvelCharactersLoader)
        XCTAssertFalse(didCallLoadThumbnail)

    }
    
    func test_search_withNilName_shouldNotCallLoaders() {
        
        var didCallMarvelCharactersLoader = false
        var didCallLoadThumbnail = false
        
        let environment = HeroesEnvironment(
            marvelCharactersLoader: {
                didCallMarvelCharactersLoader = true
                return .success()
            },
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
        
        store.send(.searchCharacter(name: nil))
        
        XCTAssertFalse(didCallMarvelCharactersLoader)
        XCTAssertFalse(didCallLoadThumbnail)

    }
    
    func test_search_withFirstHeroCellName_shouldFilterLocalState() {
        
        let heroCellData1: HeroCellData = .mock(id: 0, name: "Hero 1", thumbnailImageData: Data())
        let heroCellData2: HeroCellData = .mock(id: 0, name: "Hero 2", thumbnailImageData: Data())
        let name = heroCellData1.name
        
        var didCallMarvelCharactersLoader = false
        var didCallLoadThumbnail = false
        
        let environment = HeroesEnvironment(
            marvelCharactersLoader: {
                didCallMarvelCharactersLoader = true
                return .success()
            },
            loadThumbnail: { _ in
                didCallLoadThumbnail = true
                return .success()
            },
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        let store = TestStore(
            initialState: HoroesViewState(heroCellsData: [heroCellData1, heroCellData2]),
            reducer: heroesReducer,
            environment: environment
        )
        
        store.send(.searchCharacter(name: name)) {
            $0.heroCellsData = [heroCellData1]
        }
        
        XCTAssertFalse(didCallMarvelCharactersLoader)
        XCTAssertFalse(didCallLoadThumbnail)

    }
    
    func test_search_withName_whenDoestContainName_shouldReturnEmpty() {
        
        let heroCellData1: HeroCellData = .mock(id: 0, name: "Hero 1", thumbnailImageData: Data())
        let heroCellData2: HeroCellData = .mock(id: 0, name: "Hero 2", thumbnailImageData: Data())
        let name = "Some Name"
        
        var didCallMarvelCharactersLoader = false
        var didCallLoadThumbnail = false
        
        let environment = HeroesEnvironment(
            marvelCharactersLoader: {
                didCallMarvelCharactersLoader = true
                return .success()
            },
            loadThumbnail: { _ in
                didCallLoadThumbnail = true
                return .success()
            },
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        let store = TestStore(
            initialState: HoroesViewState(heroCellsData: [heroCellData1, heroCellData2]),
            reducer: heroesReducer,
            environment: environment
        )
        
        store.send(.searchCharacter(name: name)) {
            $0.heroCellsData = []
        }
        
        XCTAssertFalse(didCallMarvelCharactersLoader)
        XCTAssertFalse(didCallLoadThumbnail)

    }
    
}
