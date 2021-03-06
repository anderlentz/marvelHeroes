import Combine
import CoreHTTPClient
import Foundation
import HeroesAPI
import Feature_Heroes
import Feature_HeroDetails
import URLSessionHTTPClient
import UIKit

class HeroesDependencies {
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var errorImageData = {
        UIImage(named: "image_not_available")!.jpegData(compressionQuality: 0.5)!
    }()
    
    let imageCache = ImageCache()
    let marvelCharactersCache = NSMarvelCharacterCache()
    
    func makeRemoteMarvelCharactersLoader(offset: Int) -> AnyPublisher<[MarvelCharacter], Error> {
        let url = MarvelCharactersAPI.characters(offset: offset).url!
        
        return httpClient
            .getPublisher(url: url)
            .tryMap(MarvelCharacterItemsMapper.map)
            .eraseToAnyPublisher()
    }
    
    func makeThumbnailLoader(url: URL) -> AnyPublisher<Data, Never> {
        return imageCache
            .retrieve(from: url)
            .flatMap { data -> AnyPublisher<Data, Never> in
                guard let data = data else {
                    return self.httpClient
                            .getPublisher(url: url)
                            .caching(to: self.imageCache, using: url)
                            .replaceError(with: self.errorImageData)
                            .eraseToAnyPublisher()
                    
                }
                return Just(data).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func makeRemoteMarvelCharactersByNameLoader(name: String) -> AnyPublisher<[MarvelCharacter], Error> {
        let url = MarvelCharactersAPI.charactersByName(startingWithName: name).url!
        
        return httpClient
            .getPublisher(url: url)
            .tryMap(MarvelCharacterItemsMapper.map)
            .eraseToAnyPublisher()
    }
    
    func loadDetails(id: Int) -> AnyPublisher<CharacterDetails, Error> {
        let url = MarvelCharactersAPI.characterDetails(id: id).url!
        
        return httpClient
            .getPublisher(url: url)
            .tryMap(MarvelCharacterDetailsMapper.map)
            .eraseToAnyPublisher()
    }
    
}
