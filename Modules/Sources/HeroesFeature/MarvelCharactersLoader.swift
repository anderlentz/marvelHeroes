import Foundation

public protocol MarvelCharactersLoader {
    func loadCharacter(from url: URL) throws -> Data
}
