import Foundation

public protocol HTTPClient {    
    @discardableResult
    func get(from url: URL) async throws -> Data
}

