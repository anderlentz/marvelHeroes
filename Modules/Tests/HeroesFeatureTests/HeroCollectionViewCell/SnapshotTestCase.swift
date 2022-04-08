import SnapshotTesting
import XCTest
@testable import HeroesFeature

class SnapshotTestCase: XCTestCase {
    
    func testHeroCollectionViewCell() {
        let fakeImage = UIColor.yellow.image()
        let sut = HeroCollectionViewCell()
        
        sut.data = .init(name: "Test", thumbnail: fakeImage)
        
        assertSnapshot(matching: sut, as: .image(size: .init(width: 44, height: 44)))
    }
    
}
