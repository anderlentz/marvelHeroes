import Foundation
import UIKit

public struct HeroCellData: Hashable {
    public let id: Int
    public let name: String
    public let thumbnail: Data
    public let description: String
    
    public init(id: Int, name: String, thumbnail: Data, description: String = "") {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }
}
