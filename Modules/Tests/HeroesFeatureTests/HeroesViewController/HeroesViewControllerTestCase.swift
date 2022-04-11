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
                        .init(id: 1, name: "Test1", thumbnail: UIColor.gray.image().pngData()!),
                        .init(id: 2, name: "Test2", thumbnail: UIColor.blue.image().pngData()!),
                        .init(id: 3, name: "Test3", thumbnail: UIColor.green.image().pngData()!),
                        .init(id: 4, name: "Test4", thumbnail: UIColor.black.image().pngData()!)
                    ]
                ),
                 reducer: .empty,
                 environment: Void()
            )
        )
                
        assertSnapshot(matching: sut, as: .image())
    }
    
}
