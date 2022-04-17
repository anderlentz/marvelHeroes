import XCTest
@testable import HeroesAPI
@testable import Feature_Heroes

final class MarvelCharacterItemsMapperTestCase: XCTestCase {
    
    func test_map_withValidData_returnsMarvelCharacters() throws {
        let character1 = makeMarvelCharacter(
            id: 1,
            name: "Name1",
            description: "Description",
            thumbnail: (path: "http://some-path.com/1", imageExtesion: "jpg")
        )
        
        let character2 = makeMarvelCharacter(
            id: 2,
            name: "Name2",
            description: "",
            thumbnail: (path: "http://some-path.com/2", imageExtesion: "jpg")
        )
        
        let validMarvelCharactersJson = makeMarvelCharactersJSON(
            [
                character1.json,
                character2.json
            ]
        )
        
        let result = try MarvelCharacterItemsMapper.map(validMarvelCharactersJson)
        
        XCTAssertEqual(result, [character1.model, character2.model])
        
    }
    
    func test_map_withEmptyData_returnsEmptyMarvelCharacters() throws {
        
        let emptyMarvelCharactersJson = makeMarvelCharactersJSON( [] )
        
        let result = try MarvelCharacterItemsMapper.map(emptyMarvelCharactersJson)
        
        XCTAssertEqual(result, [])
        
    }
    
    func test_map_withInvalidData_returnsError() throws {
        
        let invalidCharacterJson = [
            "id": "wrong id type",
            "name": "name",
            "description": "description"
        ]
        
        let emptyMarvelCharactersJson = makeMarvelCharactersJSON( [invalidCharacterJson] )
        
        XCTAssertThrowsError(try MarvelCharacterItemsMapper.map(emptyMarvelCharactersJson))
        
    }
    
    // MARK: - Helpers
    
    private func makeMarvelCharacter(
        id: Int,
        name: String,
        description: String,
        thumbnail: (path: String, imageExtesion: String)
    ) -> (json: [String: Any], model: MarvelCharacter) {
        
        let thumbnailURL = thumbnail.path.appending(".").appending(thumbnail.imageExtesion)
        let character = MarvelCharacter(id: id, name: name, description: description, thumbnailURL: thumbnailURL)
        
        let json = [
            "id": id,
            "name": name,
            "description": description,
            "thumbnail": [
                "path": thumbnail.path,
                "extension": thumbnail.imageExtesion
            ]
        ].compactMapValues { $0 }
        
        return (json, character)
        
    }
    
}
