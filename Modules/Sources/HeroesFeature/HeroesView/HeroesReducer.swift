import ComposableArchitecture
import CoreUtils
import UIKit

public typealias HeroesReducer = Reducer<HeroesViewState, HeroesViewAction, HeroesEnvironment>

private let mainHeroesReducer = HeroesReducer { state, action, environment in
    switch action {
    case .load:
        return environment
            .marvelCharactersLoader(state.paginationState.currentOffset)
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
            if state.lastSearch.isEmpty == false {
                return Effect(value: .load).debounce(id: SearchId(), for: 0.5, scheduler: environment.mainQueue).eraseToEffect()
            }
            return .none
        }
        
        state.lastSearch = name
        return Effect(value: .loadCharacter(name: name)).debounce(id: SearchId(), for: 0.5, scheduler: environment.mainQueue).eraseToEffect()
        
    case let .loadCharacter(name: name):
        return environment
            .loadMarvelCharacters(name)
            .mapError(CommonErrors.init)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HeroesViewAction.receiveCharacters)
        
    case .loadMoreCharacters:
        state.paginationState.nextOffset()
        return environment
            .marvelCharactersLoader(state.paginationState.currentOffset)
            .removeDuplicates()
            .mapError(CommonErrors.init)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HeroesViewAction.receivedLoadMoreCharacters)
       
    case let .receivedLoadMoreCharacters(.success(characters)):
        return .merge(
            characters.map { character in
                return environment
                    .loadThumbnail(URL(string: character.thumbnailURL)!)
                    .map { data in
                        return HeroesViewAction.appendCell(
                            cell: HeroCellData(id: character.id, name: character.name, thumbnail: data, description: character.description)
                        )
                    }
                    .receive(on: environment.mainQueue)
                    .eraseToEffect()
            }
        )
        
    case .receivedLoadMoreCharacters(.failure):
        return .none
        
    case let .appendCell(cell: cell):
        state.heroCellsData.append(cell)
        return .none
    
    case .navigateToHeroDetails:
        return .none
    
    case .setNavigation:
        return .none
        
    }
}


public let heroesReducer: HeroesReducer = .combine(
    [
        mainHeroesReducer
    ]
)
