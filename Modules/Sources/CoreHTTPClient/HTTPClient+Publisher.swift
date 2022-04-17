import Foundation
import Combine

public extension HTTPClient {
    typealias Publisher = AnyPublisher<Data, Error>
    
    func getPublisher(url: URL) -> Publisher {
        return Deferred {
            Future { completion in
                Task {
                    let result = try await self.get(from: url)
                    completion(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
