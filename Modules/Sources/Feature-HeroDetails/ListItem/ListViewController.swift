import UIKit

public class ListViewController: UICollectionViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, ListItemData>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ListItemData>
    
    private var dataSource: DataSource?
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    var showLoadingIndicator: Bool = false {
        didSet {
            if showLoadingIndicator == false {
                self.collectionView.isHidden = false
                loadingIndicator.stopAnimating()
            } else {
                self.collectionView.isHidden = true
                loadingIndicator.startAnimating()
            }
        }
    }
        
    // MARK: - Initializer
    public init() {
        super.init(collectionViewLayout: Self.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        configureCollectionView()
        self.collectionView.isHidden = true
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true

        view.addSubview(loadingIndicator)

        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func configureCollectionView() {
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)

        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItemData> { cell, indexPath, comic in
            var content = cell.defaultContentConfiguration()
            content.text = comic.title
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, ListItemData>(
            collectionView: collectionView
        ) { collectionView, indexPath, comic in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: comic)
        }
    
    }
    
    func applySnapshot(from comics: [ListItemData]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([0])
        snapshot.appendItems(comics)
        
        dataSource?.apply(snapshot)
    }
    
    private static func createLayout() -> UICollectionViewLayout {
        let appearance = UICollectionLayoutListConfiguration.Appearance.insetGrouped
        return UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: appearance)
            config.backgroundColor = .clear
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
}
