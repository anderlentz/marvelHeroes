import Foundation

public struct HeroDetailsState: Equatable {
    let title: String
    let description: String
    let imageData: Data
    
    public init(title: String, description: String, imageData: Data) {
        self.title = title
        self.description = description
        self.imageData = imageData
    }
}
