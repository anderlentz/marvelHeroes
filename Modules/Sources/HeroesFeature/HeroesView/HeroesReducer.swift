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
        state.heroCellsData = []
        return Effect(value: .loadThumbnail(characters: characters))
        
    case let .loadThumbnail(characters):
        return .merge(
            characters.map { character in
                return environment
                    .loadThumbnail(URL(string: character.thumbnailURL)!)
                    .map { data in
                        return HeroesViewAction.show(
                            cell: HeroCellData(id: character.id, name: character.name, thumbnail: data, description: character.description)
                        )
                    }
                    .receive(on: environment.mainQueue)
                    .eraseToEffect()
            }
        )
        
    case let .show(cell: cell):
        guard state.heroCellsData.contains(where: { $0.id == cell.id}) == false else { return .none }
        state.heroCellsData.append(cell)
        return .none
        
    case let .searchCharacter(name: name):
        struct SearchId: Hashable {}
        guard let name = name, name.isEmpty == false else {
            return .none
        }
        return Effect(value: .loadCharacter(name: name)).debounce(id: SearchId(), for: 0.5, scheduler: environment.mainQueue).eraseToEffect()
        
    case let .loadCharacter(name: name):
        return environment
            .loadMarvelCharacters(name)
            .mapError(CommonErrors.init)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HeroesViewAction.receiveCharacters)
       
    }
}
