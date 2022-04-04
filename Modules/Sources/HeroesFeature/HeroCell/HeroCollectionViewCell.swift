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
        addSubview(thumbnail)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HeroCollectionViewCell {
    struct Data {
        let thumbnail: UIImage
    }
}
