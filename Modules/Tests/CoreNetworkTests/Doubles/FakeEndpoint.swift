import Foundation
@testable import CoreNetwork

enum FakeEndpoint: Endpoint {
    
    case fakeEndpoint
    
    var baseURL: String {
        "https://fakebaseurl.com"
    }
    
    var path: String {
        switch self {
        case .fakeEndpoint:
            return "/fakePath"
        }
    }
    
    var queryItems: [URLQueryItem] { [.fakeQueryItem] }
    var parameters: [String: String]? { ["fakeKey": "fakeValue"] }
    var method: HTTPMethod { .get }

}
