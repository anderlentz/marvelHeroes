import Combine
import ComposableArchitecture
import UIKit

public class HeroDetailsViewController: UIViewController {
    
    private let theView: HeroDetailsView = HeroDetailsView()
    private let viewStore: ViewStore<HeroDetailsState, HeroDetailsAction>
    private var cancellables: Set<AnyCancellable> = []
    
    
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
    }
}
