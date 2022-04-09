import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var parameters: [String: String]? { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    public var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path.append(path)

        if method == .get {
            urlComponents?.queryItems = queryItems.isEmpty ? nil : queryItems
        }

        return urlComponents?.url
    }
}
