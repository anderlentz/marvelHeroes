import Foundation

public enum Segment: Int {
    case comics
    case series
    case stories
    
    var title: String {
        switch self {
        case .comics:
            return "Comics"
            
        case .series:
            return "Series"
            
        case .stories:
            return "Stories"
        }
    }
}
