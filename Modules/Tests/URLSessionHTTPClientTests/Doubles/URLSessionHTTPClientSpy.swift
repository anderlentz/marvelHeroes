import Foundation
import URLSessionHTTPClient

final class URLSessionSpy: URLSessionProtocol {
    
    private(set) var calledURLs: [URL] = []
    
    let result: Result<(Data, URLResponse), Error>
    
    init(result: Result<(Data, URLResponse), Error>) {
        self.result = result
    }
    
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        self.calledURLs.append(url)
        return try result.get()
    }
    
}
