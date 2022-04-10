import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var parameters: [String: String]? { get }
    var method: HTTPMethod { get }
}

public extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path.append(path)

        if method == .get {
            urlComponents?.queryItems = queryItems.isEmpty ? nil : queryItems
        }

        return urlComponents?.url
    }
}
