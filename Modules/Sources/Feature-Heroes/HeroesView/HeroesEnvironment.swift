import Combine
import ComposableArchitecture
import Foundation

public struct HeroesEnvironment {
    var marvelCharactersLoader: (Int) -> AnyPublisher<[MarvelCharacter], Error>
    var loadThumbnail: (URL) -> AnyPublisher<Data, Never>
    var loadMarvelCharacters: (String) -> AnyPublisher<[MarvelCharacter], Error>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(
        marvelCharactersLoader : @escaping (Int) -> AnyPublisher<[MarvelCharacter], Error>,
        loadThumbnail: @escaping (URL) -> AnyPublisher<Data, Never>,
        loadMarvelCharacters: @escaping (String) -> AnyPublisher<[MarvelCharacter], Error>,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.marvelCharactersLoader = marvelCharactersLoader
        self.loadThumbnail = loadThumbnail
        self.loadMarvelCharacters = loadMarvelCharacters
        self.mainQueue = mainQueue
    }
}
