import ComposableArchitecture
import CoreUtils

public typealias HeroDetailsReducer = Reducer<HeroDetailsState, HeroDetailsAction, HeroDetailsEnvironment>

public let heroDetailsReducer = HeroDetailsReducer { state, action, environment in
    
    switch action {
    case .loadDetails:
        return environment
            .loadCharacterDetails(state.characterId)
            .mapError(CommonErrors.init)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HeroDetailsAction.receiveDetails)
        
    case let .receiveDetails(.success(details)):
        state.heroDetails = details
        state.isLoading = false
        return .none
        
    case .receiveDetails(.failure):
        state.isLoading = false
        return .none
        
    case let .didSelect(segment: segment):
        state.selectedSegment = segment
        return .none
    }
   
}
