import Combine
import ComposableArchitecture
import CoreUI
import Foundation
import UIKit

public class HeroesViewController: UICollectionViewController {
    
    // MARK: - Define
    private typealias DataSource = UICollectionViewDiffableDataSource<HeroesSection, HeroCellData>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HeroesSection, HeroCellData>
    
    // MARK: - Properties
    private let viewStore: ViewStore<HoroesViewState, HeroesViewAction>
    
    private(set) var sections: [HeroesSection] = [.main]
    private var searchController = UISearchController(searchResultsController: nil)
    private var dataSource: DataSource?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Initializer
    public init(store: Store<HoroesViewState, HeroesViewAction>) {
        self.viewStore = ViewStore(store)
        super.init(collectionViewLayout: HeroesViewController.getUICollectionViewFlowLayout())
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        navigationItem.title = "Marvel Heroes"
        configureSearchController()
        configureCollectionView()
        createDataSource()
        
        self.viewStore.publisher
            .heroCellsData
            .sink { [weak self] data in
                self?.applySnapshot(from: data)
            }
            .store(in: &self.cancellables)
        
        self.viewStore.send(.load)
    }
    
    // MARK: - Config View
    
    private func configureCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(
            HeroCollectionViewCell.self,
            forCellWithReuseIdentifier: HeroCollectionViewCell.reusableIdentifier
        )
    }
    
    private static func getUICollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let screenWidth = UIScreen.main.bounds.width - 24
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        
        return flowLayout
    }
    
    private func configure<T: SelfConfiguringCell>(
        _ cellType: T.Type,
        with data: HeroCellData,
        for indexPath: IndexPath
    ) -> T where T.DataType == HeroCellData {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: data)
        return cell
    }
    
    private func createDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, heroCellData in
                self.configure(HeroCollectionViewCell.self, with: heroCellData, for: indexPath)
            }
        )
    }
    
    private func applySnapshot(from heroCellsData: [HeroCellData]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        
        for section in sections {
            snapshot.appendItems(heroCellsData, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Heroes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let heroCellData = dataSource?.itemIdentifier(for: indexPath) else {
          return
        }
        
        // TODO: Improve navigation, maybe with Coordinator Pattern? ;)
        
        navigationController?.pushViewController(
            HeroDetailsViewController(
                store: .init(
                    initialState: HeroDetailsState(
                        title: heroCellData.name,
                        description: heroCellData.description,
                        imageData: heroCellData.thumbnail
                    ),
                    reducer: .empty,
                    environment: Void()
                )
            ),
            animated: true
        )
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension HeroesViewController: UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) {
        viewStore.send(.searchCharacter(name: searchController.searchBar.text))
    }
    
}
