import Foundation
import HeroesFeature
import Feature_HeroDetails

enum AppAction: Equatable {
    case heroes(HeroesViewAction)
    case heroDetails(HeroDetailsAction)
}
