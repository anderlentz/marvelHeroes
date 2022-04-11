import Foundation
import UIKit

class HeroDetailsView: UIView {
    
    let backgroundImage = UIImageView()
    let descriptionLabel = UILabel()
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect = .zero) {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
       
        super.init(frame: frame)
 
        setupGradient()
        
        backgroundColor = .systemBackground

        addSubview(backgroundImage)
        addSubview(descriptionLabel)

        backgroundImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -16).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }

    private func setupGradient() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 0.4, 1]
        backgroundImage.layer.addSublayer(gradientLayer)
    }
}
