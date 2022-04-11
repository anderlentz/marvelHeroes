import Foundation
import CoreNetwork

public enum MarvelCharactersAPI: Endpoint {
    
    case characters
    
    public var baseURL: String {
        "https://gateway.marvel.com"
    }
    
    public var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        }
    }
    
    public var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "ts", value: EnvironmentKeys.timestamp),
            URLQueryItem(name: "hash", value: EnvironmentKeys.hash),
            URLQueryItem(name: "apikey", value: EnvironmentKeys.publicKey)
        ]
    }
    
    public var parameters: [String : String]? { nil }
    
    public var method: HTTPMethod {
        .get
    }
    
}


private extension MarvelCharactersAPI {
    struct EnvironmentKeys {
        static let timestamp: String = "1"
        static let publicKey: String = "5dba0226149048f6e9ccf857231a4b2b"
        static let hash = "a82e97b092c45c96df314d88583c2efb"
    }
}
