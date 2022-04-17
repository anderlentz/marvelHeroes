import Foundation
import HeroesFeature
import Feature_HeroDetails

struct AppState: Equatable {
    var heroState: HeroesViewState = .init()
    var heroDetailsState: HeroDetailsState?
}
