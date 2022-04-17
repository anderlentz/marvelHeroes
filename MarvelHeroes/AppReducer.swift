import ComposableArchitecture
import HeroesFeature
import Feature_HeroDetails

typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

private let mainAppReducer = AppReducer { state, action, environment in
    
    switch action {
    case let .heroes(.navigateToHeroDetails(heroCellData: heroCellData)):
        state.heroDetailsState = .init(
            title: heroCellData.name,
            description: heroCellData.description,
            imageData: heroCellData.thumbnail,
            characterId: heroCellData.id
        )
        return .none
        
    case .heroes(.setNavigation(isActive: false)):
        state.heroDetailsState = nil
        return .none
        
    case .heroes:
        return .none
        
    case .heroDetails:
        return .none
    }
    
}


let appReducer: AppReducer = .combine(
    [
        heroesReducer
            .pullback(
                state: \.heroState,
                action: /AppAction.heroes,
                environment: { env in
                    env.heroesEnvironment
                }
            ),
        heroDetailsReducer
            .optional()
            .pullback(
                state: \.heroDetailsState,
                action: /AppAction.heroDetails,
                environment: { env in
                    env.heroDetailsEnvironment
                }
            ),
        mainAppReducer
    ]
)
