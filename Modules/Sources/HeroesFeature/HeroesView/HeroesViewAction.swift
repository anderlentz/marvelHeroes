import Foundation

public enum HeroesViewAction: Equatable {
    case load
    case receiveCharacters(Result<[MarvelCharacter], CommonErrors>)
    case loadThumbnail(characters: [MarvelCharacter])
    case show(cell: HeroCellData)
}