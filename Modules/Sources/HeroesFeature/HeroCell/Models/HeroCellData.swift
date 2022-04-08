import Foundation
import UIKit

public struct HeroCellData: Hashable {
    var id = UUID()
    let name: String
    let thumbnail: UIImage
    
    public init(name: String, thumbnail: UIImage) {
        self.name = name
        self.thumbnail = thumbnail
    }
}
