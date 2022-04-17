import XCTest
@testable import Feature_Heroes

class HeroesViewControllerPropertiesTestCase: XCTestCase {
    
    func test_sections_mustContainOnlyTheMainSection() {
        let sut = HeroesViewController(store: .init(initialState: .init(), reducer: .empty, environment: Void()))
        
        XCTAssertEqual(sut.sections, [.main])
    }
    
    func test_collectionView_shouldHaveOnlyOneSection() {
        let sut = HeroesViewController(store: .init(initialState: .init(), reducer: .empty, environment: Void()))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
    }
    
    func test_collectionView_withEmptyState_shouldNotHaveItems() {
        let sut = HeroesViewController(store: .init(initialState: .init(), reducer: .empty, environment: Void()))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func test_collectionView_numberOfItems_withNonEmptyInitialDataState_shouldHaveItems() {
        let data: [HeroCellData] = [
            .init(id: 1, name: "Test1", thumbnail: UIColor.red.image().pngData()!),
            .init(id: 1, name: "Test2", thumbnail: UIColor.blue.image().pngData()!)
        ]
        let sut = HeroesViewController(store: .init(initialState: .init(heroCellsData: data), reducer: .empty, environment: Void()))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 2)
    }
    
}
