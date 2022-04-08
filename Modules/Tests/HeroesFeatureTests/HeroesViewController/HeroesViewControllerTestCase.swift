import SnapshotTesting
import XCTest
@testable import HeroesFeature

class HeroesViewControllerTestCase: XCTestCase {
    
    func test_init_WithEmptyData_shouldNotDisplayCells() {
        let sut =  HeroesViewController(
            store: .init(
                initialState: .init(),
                 reducer: .empty,
                 environment: Void()
            )
        )
                
        assertSnapshot(matching: sut, as: .image())
    }
    
    func test_init_withInitialData_shouldDisplayCells() {
        let sut =  HeroesViewController(
            store: .init(
                initialState: .init(
                    heroCellsData: [
                        .init(name: "Test1", thumbnail: UIColor.gray.image()),
                        .init(name: "Test1", thumbnail: UIColor.blue.image()),
                        .init(name: "Test1", thumbnail: UIColor.green.image()),
                        .init(name: "Test1", thumbnail: UIColor.black.image())
                    ]
                ),
                 reducer: .empty,
                 environment: Void()
            )
        )
                
        assertSnapshot(matching: sut, as: .image())
    }
    
}
