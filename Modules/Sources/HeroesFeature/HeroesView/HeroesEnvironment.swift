import Combine
import ComposableArchitecture
import Foundation

public struct HeroesEnvironment {
    var marvelCharactersLoader: () -> AnyPublisher<[MarvelCharacter], Error>
    var loadThumbnail: (URL) -> AnyPublisher<Data, Never>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(
        marvelCharactersLoader : @escaping () -> AnyPublisher<[MarvelCharacter], Error>,
        loadThumbnail: @escaping (URL) -> AnyPublisher<Data, Never>,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.marvelCharactersLoader = marvelCharactersLoader
        self.loadThumbnail = loadThumbnail
        self.mainQueue = mainQueue
    }
}
