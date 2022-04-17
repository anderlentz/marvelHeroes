import Combine
import ComposableArchitecture
import UIKit
import HeroesFeature
import Feature_HeroDetails

class AppRootViewController: UINavigationController {
    
    private let viewStore: ViewStore<AppState, AppAction>
    private let store: Store<AppState, AppAction>
    private var cancellables: Set<AnyCancellable> = []
    
    var currentPresentedViewController: UIViewController?
    
    
    public init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
        super.init(nibName: nil, bundle: nil)
        
        let heroesStore  = self.store
          .scope(state: \.heroState, action: AppAction.heroes)
        
        let initialViewController = HeroesViewController(store: heroesStore)
          
        pushViewController(initialViewController, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.store
              .scope(state: \.heroDetailsState, action: AppAction.heroDetails)
              .ifLet(
                then: { [weak self] childStore in
                self?.pushViewController(
                    HeroDetailsViewController(store: childStore),
                    animated: true
                  )
                },
                else: { [weak self] in
                  guard let self = self else { return }
                    self.popToViewController(self, animated: true)
                }
              )
              .store(in: &self.cancellables)
    }
    
}
