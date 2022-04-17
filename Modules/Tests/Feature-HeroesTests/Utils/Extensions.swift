import Combine
import Foundation
@testable import Feature_Heroes

extension AnyPublisher where Output == [MarvelCharacter], Failure == Error {
    static func success(result: [MarvelCharacter] = []) -> Self {
        Just(result)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    static func failure(error: Error) -> Self {
        return Fail(
            outputType: Output.self,
            failure: error
        )
            .eraseToAnyPublisher()
    }
}

extension AnyPublisher where Output == Data, Failure == Never  {
    static func success(data: Data = Data()) -> Self {
        Just(data)
            .eraseToAnyPublisher()
    }
}

extension MarvelCharacter {
    static func mock(id: Int, name: String, description: String, thumbnailURL: String) -> Self {
        .init(id: id, name: name, description: description, thumbnailURL: thumbnailURL)
    }
    
    static var anyCharacter: Self { .mock(id: 0, name: "Name", description: "Description", thumbnailURL: "http://any-url/image.jpg") }
}

extension HeroCellData {
    static func mock(id: Int, name: String, thumbnailImageData: Data) -> Self {
        .init(id: id, name: name, thumbnail: thumbnailImageData)
    }
}
