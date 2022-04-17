import XCTest
@testable import URLSessionHTTPClient
//import ComposableArchitecture

final class URLSessionHTTPClientTestCase: XCTestCase {
    
    func test_init_doesNotPerformRequest() {
        let result: Result<(Data, URLResponse), Error> = .anyValidResult
        let session = URLSessionSpy(result: result)
        
        let _ = makeSUT(result: result, session: session)
        
        XCTAssertEqual(session.calledURLs, [])
    }
    
    func test_get_performsGetResquet() async {
        let result: Result<(Data, URLResponse), Error> = .anyValidResult
        let session = URLSessionSpy(result: result)
        
        let sut = makeSUT(result: result, session: session)
        
        _ = try? await sut.get(from: .anyURL)
        
        XCTAssertEqual(session.calledURLs, [.anyURL])
    }
    
    func test_get_withNon200Response_deliversInvalidDataError() async {
        let sut = makeSUT(result: .mockInvalidResult(code: 400))
        
        do {
            _ = try await sut.get(from: .anyURL)
            XCTFail("Expected invalidData error")
        } catch {
            XCTAssertEqual(error as? URLSessionHTTPClient.URLSessionError, .invalidData)
        }
    }
    
    func test_get_withSomeError_deliversConnectivityError() async {
        let sut = makeSUT(result: .anyErrorResult)
        
        do {
            _ = try await sut.get(from: .anyURL)
            XCTFail("Expected connectivity error")
        } catch {
            XCTAssertEqual(error as? URLSessionHTTPClient.URLSessionError, .connectivity)
        }
    }
    
    func test_get_withValid200Response_deliversData() async {
        
        let validData = Data("some-data".utf8)
        let validResponse: URLResponse = .httpResponse(code: 200)
        let sut = makeSUT(result: .success((validData, validResponse)))
        
        do {
            let receivedData = try await sut.get(from: .anyURL)
            XCTAssertEqual(receivedData, validData)
        } catch {
            XCTFail("Expected data instead an error \(error)")
        }
    }
    
    // MARK: - Helpers
    
    func makeSUT(
        result: Result<(Data, URLResponse), Error> = .anyValidResult,
        session: URLSessionSpy? = nil
    ) -> URLSessionHTTPClient {
        
        guard let session = session else {
            return URLSessionHTTPClient(session: URLSessionSpy(result: result))
        }

        return URLSessionHTTPClient(session: session)
    }

}

extension URL {
    static let anyURL = URL(string: "any-url.com")!
}

extension Result where Success == (Data, URLResponse) {
    static var anyValidResult: Self {
        .success((Data(), .httpResponse(code: 200)))
    }
    
    static func mockInvalidResult(code: Int) -> Self {
        .success((Data(), .httpResponse(code: code)))
    }
}

extension Result where Failure == Error {
    static var anyErrorResult: Self {
        .failure(NSError(domain: "any-error", code: 0))
    }
}

extension URLResponse {
    static func httpResponse(code: Int) -> HTTPURLResponse {
        return .init(url: .anyURL, statusCode: code, httpVersion: nil, headerFields: nil)!
    }
}
