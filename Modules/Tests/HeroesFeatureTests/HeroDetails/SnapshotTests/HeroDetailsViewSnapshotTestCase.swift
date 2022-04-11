import SnapshotTesting
import XCTest
@testable import HeroesFeature

class HeroDetailsViewSnapshotTestCase: XCTestCase {

    func test_view_withSmallDescription_display() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: .init(title: "Title", description: "Description", imageData: UIColor.red.image().pngData()!),
                reducer: .empty,
                environment: Void()
            )
        )
        
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_view_withLargeDescription_display() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: .init(title: "Title", description: "Some large description. Some large description. Some large description. Some large description.", imageData: UIColor.red.image().pngData()!),
                reducer: .empty,
                environment: Void()
            )
        )
        
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_view_withEmpryDescription_display() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: .init(title: "Title", description: "", imageData: UIColor.red.image().pngData()!),
                reducer: .empty,
                environment: Void()
            )
        )
        
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
}
