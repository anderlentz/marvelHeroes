import Foundation

public enum CommonErrors: Error, Equatable {
    case text(String)
    case incompleteDataFor(object: String)
    case unexpectedRawValueFor(object: String)

    public static func incompleteDataFor(object: Any.Type) -> Self { .incompleteDataFor(object: String(reflecting: object)) }
    public static func unexpectedRawValueFor(object: Any.Type) -> Self { .unexpectedRawValueFor(object: String(reflecting: object)) }

    public init(_ error: Error) {
        self = .text(error.localizedDescription)
    }
}
