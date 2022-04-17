import Foundation
import Feature_Heroes
import Feature_HeroDetails

struct AppState: Equatable {
    var heroState: HeroesViewState = .init()
    var heroDetailsState: HeroDetailsState?
}
