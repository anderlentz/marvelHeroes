import XCTest
@testable import HeroesAPI

final class MarvelCharactersAPITestCase: XCTestCase {
    
    func test_charactersAPI_defaultProperties() {
        let sut = MarvelCharactersAPI.characters(offset: 0)
        
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.baseURL, "https://gateway.marvel.com")
        XCTAssertEqual(sut.path, "/v1/public/characters")
        XCTAssertEqual(
            sut.queryItems,
            [
                URLQueryItem(name: "ts", value: "1"),
                URLQueryItem(name: "hash", value: "a82e97b092c45c96df314d88583c2efb"),
                URLQueryItem(name: "apikey", value: "5dba0226149048f6e9ccf857231a4b2b"),
                URLQueryItem(name: "offset", value: "0")
            ]
        )
    }
    
}
