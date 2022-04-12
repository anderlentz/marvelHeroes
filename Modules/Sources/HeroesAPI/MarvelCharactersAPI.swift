import Foundation
import CoreNetwork

public enum MarvelCharactersAPI: Endpoint {
    
    case characters(offset: Int)
    case charactersByName(startingWithName: String)
    
    public var baseURL: String {
        "https://gateway.marvel.com"
    }
    
    public var path: String {
        switch self {
        case .characters, .charactersByName(startingWithName: _):
            return "/v1/public/characters"
        }
    }
    
    public var queryItems: [URLQueryItem] {
        var queryItems = authenticationQueryItems()
        
        switch self {
        case let .characters(offset):
            queryItems.append(offsetQuery(offset))
            return queryItems
            
        case let .charactersByName(startingWithName: name):
            queryItems.append(startingWithNameQuery(name))
            return queryItems
        }
    }
    
    public var parameters: [String : String]? { nil }
    
    public var method: HTTPMethod {
        .get
    }
    
    private func authenticationQueryItems() -> [URLQueryItem] {
        [
            URLQueryItem(name: "ts", value: EnvironmentKeys.timestamp),
            URLQueryItem(name: "hash", value: EnvironmentKeys.hash),
            URLQueryItem(name: "apikey", value: EnvironmentKeys.publicKey)
        ]
    }
    
    private func startingWithNameQuery(_ name: String) -> URLQueryItem {
        URLQueryItem(name: "nameStartsWith", value: name)
    }
    
    private func offsetQuery(_ offset: Int) -> URLQueryItem {
        URLQueryItem(name: "offset", value: "\(offset)")
    }
}


private extension MarvelCharactersAPI {
    struct EnvironmentKeys {
        static let timestamp: String = "1"
        static let publicKey: String = "5dba0226149048f6e9ccf857231a4b2b"
        static let hash = "a82e97b092c45c96df314d88583c2efb"
    }
}
