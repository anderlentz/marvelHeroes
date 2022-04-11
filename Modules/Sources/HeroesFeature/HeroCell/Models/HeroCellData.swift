import Foundation
import UIKit

public struct HeroCellData: Hashable {
    var id: Int
    let name: String
    let thumbnail: Data
    let description: String
    
    public init(id: Int, name: String, thumbnail: Data, description: String = "") {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }
}
