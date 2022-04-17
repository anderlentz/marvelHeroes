import Foundation
import Feature_Heroes
import Feature_HeroDetails

enum AppAction: Equatable {
    case heroes(HeroesViewAction)
    case heroDetails(HeroDetailsAction)
}
