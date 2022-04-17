import Foundation

public struct MarvelCharacter: Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnailURL: String
    
    public init(
        id: Int,
        name: String,
        description: String,
        thumbnailURL: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnailURL = thumbnailURL
    }
}
