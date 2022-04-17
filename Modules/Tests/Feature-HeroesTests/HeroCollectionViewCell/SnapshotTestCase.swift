import SnapshotTesting
import XCTest
@testable import Feature_Heroes

class SnapshotTestCase: XCTestCase {
    
    func test_configure_HeroCollectionViewCell() {
        let fakeImageData = UIColor.yellow.image().pngData()!
        let sut = HeroCollectionViewCell()
        
        sut.configure(with: .mock(id: 1, name: "Test1", thumbnailImageData: fakeImageData))
                
        assertSnapshot(matching: sut, as: .image(size: .init(width: 44, height: 44)))
    }
    
}
