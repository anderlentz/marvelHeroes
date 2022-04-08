//
//  File.swift
//  
//
//  Created by Anderson Lentz on 07/04/22.
//

import XCTest
@testable import HeroesFeature

class HeroesViewControllerPropertiesTestCase: XCTestCase {
    
    func test_sections_mustContainOnlyTheMainSection() {
        let sut = HeroesViewController(store: .init(initialState: .init(), reducer: .empty, environment: Void()))
        
        XCTAssertEqual(sut.sections, [.main])
    }
    
    func test_collectionView_shouldHaveOnlyOneSection() {
        let sut = HeroesViewController(store: .init(initialState: .init(), reducer: .empty, environment: Void()))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
    }
    
    func test_collectionView_withEmptyState_shouldNotHaveItems() {
        let sut = HeroesViewController(store: .init(initialState: .init(), reducer: .empty, environment: Void()))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func test_collectionView_numberOfItems_withNonEmptyInitialDataState_shouldHaveItems() {
        let data: [HeroCellData] = [
            .init(name: "Test", thumbnail: UIColor.red.image()),
            .init(name: "Test", thumbnail: UIColor.blue.image())
        ]
        let sut = HeroesViewController(store: .init(initialState: .init(heroCellsData: data), reducer: .empty, environment: Void()))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 2)
    }
    
}
