import Foundation
import HeroesFeature

public final class MarvelCharacterItemsMapper {
    private struct Root: Decodable {
        private let data: RemoteMarvelCharacterData
        
        private struct RemoteMarvelCharacterData: Decodable {
            let results: [RemoteMarvelCharacterItem]
        }
        
        private struct RemoteMarvelCharacterItem: Decodable {
            let id: Int
            let name: String
            let description: String
            let thumbnail: Thumbnail
        }
        
        private struct Thumbnail: Decodable {
            let path: String
            let imageExtension: String
            
            enum CodingKeys: String, CodingKey {
                case path
                case imageExtension = "extension"
            }
            
            var formattedPath: String {
                "\(path).\(imageExtension)"
            }
        }
        
        var characteres: [MarvelCharacter] {
            data.results.map {
                MarvelCharacter(
                    id: $0.id,
                    name: $0.name,
                    description: $0.description,
                    thumbnailURL: $0.thumbnail.formattedPath
                )
            }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data) throws -> [MarvelCharacter] {
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.characteres
    }
}
