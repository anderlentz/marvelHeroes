import UIKit

#if DEBUG
public extension UIColor {
    func image(_ size: CGSize = CGSize(width: 256, height: 256)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
#endif
