import Combine
import ComposableArchitecture
import UIKit

public class HeroDetailsViewController: UIViewController {
    
    private(set) var theView: HeroDetailsView = HeroDetailsView()
    private let viewStore: ViewStore<HeroDetailsState, HeroDetailsAction>
    private var cancellables: Set<AnyCancellable> = []
    private var currentViewController: ListViewController = ListViewController()
    
    // MARK: - Initializer
    
    public init(store: Store<HeroDetailsState, HeroDetailsAction>) {
        self.viewStore = ViewStore(store)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func loadView() {
        view = theView
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        bindViewStore()
        theView.segmentDelegate = self
        add(asChildViewController: currentViewController)
        viewStore.send(.loadDetails)
    }
    
    // MARK: - Methods
    
    private func bindViewStore() {
        self.viewStore.publisher
            .title
            .map { $0 as String? }
            .assign(to: \.title, on: navigationItem)
            .store(in: &self.cancellables)
        
        self.viewStore.publisher
            .description
            .map { $0 as String? }
            .assign(to: \.text, on: theView.descriptionLabel)
            .store(in: &self.cancellables)
        
        self.viewStore.publisher
            .imageData
            .map { UIImage(data: $0) }
            .assign(to: \.image, on: theView.backgroundImage)
            .store(in: &self.cancellables)
        
        self.viewStore.publisher
            .isLoading
            .sink { [weak self] in
                self?.currentViewController.showLoadingIndicator = $0
            }
            .store(in: &cancellables)
        
        self.viewStore.publisher
            .listContent
            .filter { $0.isEmpty == false }
            .sink { [weak self] in
                self?.currentViewController.applySnapshot(from: $0)
            }
            .store(in: &cancellables)
        
        self.viewStore.publisher
            .selectedSegment
            .sink { [weak self] in
                self?.theView.segmentedControl.selectedSegmentIndex = $0.rawValue
                self?.didSelect(segment: $0)
            }
            .store(in: &cancellables)
            
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        theView.contentView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = theView.contentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
}

extension HeroDetailsViewController: SegmentDelegate {
    func didSelect(segment: Segment) {
        viewStore.send(.didSelect(segment: segment))
    }
}
