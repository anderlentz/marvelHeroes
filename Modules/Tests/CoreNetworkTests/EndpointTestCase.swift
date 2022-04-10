import XCTest
@testable import CoreNetwork

class EndpointTestCase: XCTestCase {
    
    var sut: Endpoint = FakeEndpoint.fakeEndpoint
    
    func test_baseURL() {
        XCTAssertEqual(sut.baseURL, "https://fakebaseurl.com")
    }
    
    func test_path() {
        XCTAssertEqual(sut.path, "/fakePath")
    }
    
    func test_Method() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func test_QueryItems() {
        XCTAssertEqual(sut.queryItems, [ .fakeQueryItem ])
    }
    
    func test_parameters() {
        XCTAssertEqual(sut.parameters, ["fakeKey": "fakeValue"])
    }
    
    func test_url() {
        XCTAssertEqual(sut.url?.path, "/fakePath")
        XCTAssertEqual(sut.baseURL, "https://fakebaseurl.com")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.queryItems, [ .fakeQueryItem ])
    }
    
}
