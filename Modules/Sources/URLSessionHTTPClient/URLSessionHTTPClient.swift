import Foundation
import CoreHTTPClient

public protocol URLSessionProtocol {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public func get(from url: URL) async throws -> Data {
        guard let (data, response) = try? await session.data(from: url, delegate: nil) else {
            throw URLSessionError.connectivity
        }
        
        guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
            throw URLSessionError.invalidData
        }
        return data
        
    }
    
}

public extension URLSessionHTTPClient {
    
    enum URLSessionError: Swift.Error {
        case connectivity
        case invalidData
    }
    
}
