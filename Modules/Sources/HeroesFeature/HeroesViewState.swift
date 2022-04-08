import Foundation

public struct HoroesViewState: Equatable {
    var heroCellsData: [HeroCellData]
    
    public init(heroCellsData: [HeroCellData] = [HeroCellData]()) {
        self.heroCellsData = heroCellsData
    }
}
