# marvelHeroes

This app was built using:

- Architecture: TCA (The Composable Architecture by Point Free)
- Language: Swift + UIKit
- Xcode 13.3.1 (13E500a)
- iOS 15

# Modularization
This app is modularized using local modules via SPM. We have feature and core modules. 

  ## Core Modules
  Core Modules provides the reusable code between features. Ideally, core modules should not depend on Feature modules.
  
  - CoreHTTPClient: Abstraction for a http client allowing get network calls.
  - CoreNetwork: Contains the basic files for constructing an network endpoint.
  - CoreUI: Helpers for constructing UI elements.
  - CoreUtils: Contain some helpfull code that can be used in Feature modules.
  
  ## Feature Modules
  Feature modules can use `Core` modules but  we expect to not have other feature dependencies in feature modules.
  
  - Feature-Heroes: Responsible for showing a list of marvel characters.
  - Feature-HeroDetails: Contains the logic of showing a Marvel character detail

# Composition

The dependencies composition is made in SceneDelegate using the combination of feature reducer's at `AppReducer`. 
The `MarvelHeroes` folder acts like the composition root where we can access to all the App's dependencies and modules.
