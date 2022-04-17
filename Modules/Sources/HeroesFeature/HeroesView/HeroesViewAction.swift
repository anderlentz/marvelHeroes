import Foundation
import CoreUtils

public enum HeroesViewAction: Equatable {
    case load
    case receiveCharacters(Result<[MarvelCharacter], CommonErrors>)
    case loadThumbnail(characters: [MarvelCharacter])
    case show(cell: HeroCellData)
    case searchCharacter(name: String?)
    case loadCharacter(name: String)
    case loadMoreCharacters
    case receivedLoadMoreCharacters(Result<[MarvelCharacter], CommonErrors>)
    case appendCell(cell: HeroCellData)
    case navigateToHeroDetails(heroCellData: HeroCellData)
    case setNavigation(isActive: Bool)
}
