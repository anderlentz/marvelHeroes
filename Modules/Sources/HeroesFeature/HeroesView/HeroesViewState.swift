import Foundation

public struct HeroesViewState: Equatable {
    var heroCellsData: [HeroCellData]
    var lastSearch = ""
    var paginationState = PaginationState()
    
    let offsetIncrementation = 20
    
    public init(heroCellsData: [HeroCellData] = [HeroCellData]()) {
        self.heroCellsData = heroCellsData
    }
}

extension HeroesViewState {
    struct PaginationState: Equatable {
        var currentOffset = 0
        
        mutating func nextOffset() {
            currentOffset += 20
        }
    }
}
