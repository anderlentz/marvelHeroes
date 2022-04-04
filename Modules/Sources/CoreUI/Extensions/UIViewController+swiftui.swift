import SwiftUI
import UIKit

public extension UIViewController {
    private struct SwiftUIViewControllerWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Self.Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(
            _ uiViewController: UIViewControllerType,
            context: Self.Context
        ) {}
    }
    
    var asSwiftUIView: some View {
        SwiftUIViewControllerWrapper(viewController: self)
    }
}
