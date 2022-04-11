import ComposableArchitecture
import UIKit

public typealias HeroesReducer = Reducer<HoroesViewState, HeroesViewAction, HeroesEnvironment>

public let heroesReducer = HeroesReducer { state, action, environment in
    switch action {
    case .load:
        return environment
            .marvelCharactersLoader()
            .mapError(CommonErrors.init)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HeroesViewAction.receiveCharacters)
    
    case let .receiveCharacters(.failure(error)):
        return .none
        
    case let .receiveCharacters(.success(characters)):
        return Effect(value: .loadThumbnail(characters: characters))
        
    case let .loadThumbnail(characters):
        return .merge(
            characters.map { character in
                return environment
                    .loadThumbnail(URL(string: character.thumbnailURL)!)
                    .map { data in
                        return HeroesViewAction.show(
                            cell: HeroCellData(id: character.id, name: character.name, thumbnail: data)
                        )
                    }
                    .receive(on: environment.mainQueue)
                    .eraseToEffect()
            }
        )
        
    case let .show(cell: cell):
        state.heroCellsData.append(cell)
        return .none
    }
}
