import Foundation
import Feature_HeroDetails

public final class MarvelCharacterDetailsMapper {
    private struct Root: Decodable {
        private let data: MarvelCharacterData
        
        private struct MarvelCharacterData: Decodable {
            let results: [MarvelCharacterItem]
        }
        
        private struct MarvelCharacterItem: Decodable {
            let comics: ItemsData
            let series: ItemsData
            let stories: ItemsData
        }
        
        private struct ItemsData: Decodable {
            let items: [Item]
        }
        
        private struct Item: Decodable {
            let name: String
        }
        
        var characterDetails: CharacterDetails {
            let detailsResult = data.results.first.flatMap {
                CharacterDetails(
                    comics: $0.comics.items.map { $0.name },
                    series: $0.series.items.map { $0.name },
                    stories: $0.stories.items.map { $0.name }
                )
            }
            
            guard let details = detailsResult else { return .init() }
            return details
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data) throws -> CharacterDetails {
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.characterDetails
    }
}

