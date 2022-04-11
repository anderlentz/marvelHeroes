import CoreUI
import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

    private var thumbnail = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnail)
        
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.layer.cornerRadius = 5
        thumbnail.clipsToBounds = true
        thumbnail.contentMode = .scaleToFill
        
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
    
    typealias DataType = HeroCellData
    
    static var reusableIdentifier: String {
        String(describing: self)
    }
    
    
    func configure(with data: DataType) {
        thumbnail.image = UIImage(data: data.thumbnail)
    }
    
}
