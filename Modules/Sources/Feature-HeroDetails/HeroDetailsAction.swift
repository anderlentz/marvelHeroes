import Foundation
import CoreUtils

public enum HeroDetailsAction: Equatable {
    case loadDetails
    case receiveDetails(Result<CharacterDetails, CommonErrors>)
    case didSelect(segment: Segment)
}
