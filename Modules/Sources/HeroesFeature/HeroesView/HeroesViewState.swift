import Foundation

public struct HoroesViewState: Equatable {
    var heroCellsData: [HeroCellData]
    var lastSearch = ""
    
    public init(heroCellsData: [HeroCellData] = [HeroCellData]()) {
        self.heroCellsData = heroCellsData
    }
}
