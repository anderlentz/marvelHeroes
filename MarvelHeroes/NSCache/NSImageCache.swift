import Foundation
import Combine

class DataWrapper {
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
}

class ImageCache {
    var cache = NSCache<NSURL, DataWrapper>()
    
    func retrieve(from url: URL) -> AnyPublisher<Data?, Never> {
        let cachedVersion = cache.object(forKey: url as NSURL)
        return Just(cachedVersion?.data)
            .eraseToAnyPublisher()
    }
    
    func save(_ data: Data, from url: URL) {
        cache.setObject(DataWrapper(data: data), forKey: url as NSURL)
    }
}

extension Publisher where Output == Data {
    func caching(to cache: ImageCache, using url: URL) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { data in
            cache.save(data, from: url)
        }).eraseToAnyPublisher()
    }
}
