import Foundation
import UIKit

public struct HeroCellData: Hashable {
    var id: Int
    let name: String
    let thumbnail: Data
    
    public init(id: Int, name: String, thumbnail: Data) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
    }
}
