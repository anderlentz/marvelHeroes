import Foundation
import Combine
import HeroesFeature

class MarvelCharacterWrapper {
    let data: MarvelCharacter
    
    init(data: MarvelCharacter) {
        self.data = data
    }
}

class NSMarvelCharacterCache {
    var cache = NSCache<NSURL, MarvelCharacterWrapper>()
    
    func retrieve(from url: URL) -> AnyPublisher<MarvelCharacter?, Never> {
        let cachedVersion = cache.object(forKey: url as NSURL)
        return Just(cachedVersion?.data)
            .eraseToAnyPublisher()
    }
    
    func save(_ data: MarvelCharacter, from url: URL) {
        cache.setObject(MarvelCharacterWrapper(data: data), forKey: url as NSURL)
    }
}

extension Publisher where Output == MarvelCharacter {
    func caching(to cache: NSMarvelCharacterCache, using url: URL) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { data in
            cache.save(data, from: url)
        }).eraseToAnyPublisher()
    }
}
