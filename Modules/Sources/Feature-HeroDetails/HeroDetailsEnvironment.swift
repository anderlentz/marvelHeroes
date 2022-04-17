import Foundation
import Combine
import ComposableArchitecture

public struct CharacterDetails: Equatable {
    let comics: [String]
    let series: [String]
    let stories: [String]
    
    public init(
        comics: [String] = [],
        series: [String] = [],
        stories: [String] = []
    ) {
        self.comics = comics
        self.series = series
        self.stories = stories
    }
}


public struct HeroDetailsEnvironment {
    var loadCharacterDetails: (_ id: Int) -> AnyPublisher<CharacterDetails, Error>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init (
        loadCharacterDetails: @escaping (_ id: Int) -> AnyPublisher<CharacterDetails, Error>,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.loadCharacterDetails = loadCharacterDetails
        self.mainQueue = mainQueue
    }
}
