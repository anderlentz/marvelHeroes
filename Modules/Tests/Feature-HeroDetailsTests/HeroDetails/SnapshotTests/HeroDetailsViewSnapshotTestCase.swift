import CoreUtils
import ComposableArchitecture
import SnapshotTesting
import XCTest
@testable import Feature_HeroDetails

class HeroDetailsViewSnapshotTestCase: XCTestCase {

    func test_didSelectedComics_loading() {
        let sut =  HeroDetailsViewController(
            store: .init(initialState: mockState(isLoading: true), reducer: .empty, environment: Void())
        )
        
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedComics_withEmptyDetail() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: false, selectedSegment: .comics),
                reducer: .empty,
                environment: Void()
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedComics_withNonEmptyDetail() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: false, selectedSegment: .comics, heroDetails: .mock),
                reducer: heroDetailsReducer,
                environment: .successMock
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedSeries_loading() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: true, selectedSegment: .series),
                reducer: .empty,
                environment: Void()
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedSeries_Empty() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: false, selectedSegment: .series),
                reducer: .empty,
                environment: Void()
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedSeries_withNonEmptyDetail() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: false, selectedSegment: .series, heroDetails: .mock),
                reducer: heroDetailsReducer,
                environment: .successMock
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedStories_loading() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: true, selectedSegment: .stories),
                reducer: .empty,
                environment: Void()
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedStories_empty() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: false, selectedSegment: .stories),
                reducer: .empty,
                environment: Void()
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    func test_didSelectedStories_withNonEmptyDetail() {
        let sut =  HeroDetailsViewController(
            store: .init(
                initialState: mockState(isLoading: false, selectedSegment: .stories, heroDetails: .mock),
                reducer: heroDetailsReducer,
                environment: .successMock
            )
        )
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }
    
    
    
//    func test_view_withLargeDescription_display() {
//        let sut =  HeroDetailsViewController(
//            store: .init(
//                initialState: .init(title: "Title", description: "Some large description. Some large description. Some large description. Some large description.", imageData: UIColor.red.image().pngData()!, characterId: 0),
//                reducer: .empty,
//                environment: Void()
//            )
//        )
//
//        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
//    }
//
//    func test_view_withEmpryDescription_display() {
//        let sut =  HeroDetailsViewController(
//            store: .init(
//                initialState: .init(title: "Title", description: "", imageData: UIColor.red.image().pngData()!, characterId: 0),
//                reducer: .empty,
//                environment: Void()
//            )
//        )
//
//        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
//    }
    
    // MARK: - Helpers
    
    func mockState(
        isLoading: Bool,
        selectedSegment: Segment = .comics,
        heroDetails: CharacterDetails = .init()
    ) -> HeroDetailsState {
        .init(
            title: "Mock",
            description: "Mock Description",
            imageData: UIColor.red.image().pngData()!,
            characterId: 123,
            isLoading: isLoading,
            selectedSegment: selectedSegment
        )
    }
}

extension CharacterDetails {
    static let mock: Self = .init(
        comics: ["Mock Comics 1", "Mock Comics 2", "Mock Comics 3", "Mock Comics 4", "Mock Comics 5"],
        series: ["Mock Series 1", "Mock Series 2", "Mock Series 3", "Mock Series 4", "Mock Series 5"],
        stories: ["Mock Stories 1", "Mock Stories 2", "Mock Stories 3", "Mock Stories 4", "Mock Stories 5"]
    )
}

extension HeroDetailsEnvironment {
    static let successMock: Self = .init(
        loadCharacterDetails: { _ in
            .complete(with: .success(.mock))
            
        },
        mainQueue: .immediate.eraseToAnyScheduler()
    )
}
