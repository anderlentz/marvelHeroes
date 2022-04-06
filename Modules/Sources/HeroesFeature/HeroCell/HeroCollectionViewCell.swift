import CoreUI
import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

    private var thumbnail = UIImageView()
    
    var data: Data? {
        didSet {
            thumbnail.image = data?.thumbnail
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnail)
        
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.layer.cornerRadius = 5
        thumbnail.clipsToBounds = true
        thumbnail.contentMode = .scaleAspectFit
        
        // Layout constraints for `thumbnail`
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thumbnail.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            thumbnail.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HeroCollectionViewCell: SelfConfiguringCell {
    
    typealias DataType = Data
    
    static var reusableIdentifier: String {
        String(describing: self)
    }
    
    
    func configure(with data: Data) {
        thumbnail.image = data.thumbnail
    }
    
}
extension HeroCollectionViewCell {
    struct Data {
        let thumbnail: UIImage
    }
}
