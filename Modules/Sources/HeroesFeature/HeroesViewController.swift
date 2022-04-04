//
//  File.swift
//  
//
//  Created by Anderson Lentz on 30/03/22.
//

import CoreUI
import Foundation
import UIKit

public class HeroesViewController: UIViewController {
    
    internal var theView: HeroesView {
        return view as! HeroesView
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = HeroesView()
    }
    
}

#if DEBUG
import SwiftUI

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: HeroesViewController()
        )
        .asSwiftUIView
        .edgesIgnoringSafeArea(.all)
    }
}
#endif
