import Foundation

public struct HeroDetailsState: Equatable {
    var title: String
    var description: String
    var imageData: Data
    var characterId: Int
    var isLoading: Bool
    var heroDetails: CharacterDetails
    var selectedSegment: Segment
    var listContent: [ListItemData] {
        switch selectedSegment {
        case .comics:
            return heroDetails.comics.map { ListItemData(id: UUID(), title: $0) }
            
        case .series:
            return heroDetails.series.map { ListItemData(id: UUID(), title: $0) }
            
        case .stories:
            return heroDetails.stories.map { ListItemData(id: UUID(), title: $0) }
        }
    }
    
    public init(
        title: String,
        description: String,
        imageData: Data,
        characterId: Int,
        isLoading: Bool = true,
        heroDetails: CharacterDetails = .init(),
        selectedSegment: Segment = .comics
    ) {
        self.characterId = characterId
        self.title = title
        self.description = description
        self.imageData = imageData
        self.isLoading = isLoading
        self.heroDetails = heroDetails
        self.selectedSegment = selectedSegment
    }
}
