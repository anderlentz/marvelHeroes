import Foundation
import UIKit

protocol SegmentDelegate: AnyObject {
    func didSelect(segment: Segment)
}

class HeroDetailsView: UIView {
    
    let backgroundImage = UIImageView()
    let descriptionLabel = UILabel()
    let segmentedControl = UISegmentedControl()
    let contentView = UIView()
    
    weak var segmentDelegate: SegmentDelegate?
    
    private let containerView = UIView()
    private let gradientLayer = CAGradientLayer()
    private let segments: [Segment] = [
        .comics,
        .series,
        .stories
    ]
    
    override init(frame: CGRect = .zero) {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.7)
        containerView.clipsToBounds = true
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
       
        super.init(frame: frame)
 
        setupGradient()
        setupSegmentedControl()
        
        backgroundColor = .systemBackground

        addSubview(backgroundImage)
        addSubview(descriptionLabel)
        addSubview(containerView)
        addSubview(segmentedControl)
        addSubview(contentView)
        

        backgroundImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -16).isActive = true
        
        containerView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        segmentedControl.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 16).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        contentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 4).isActive = true
        contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
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
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        
        for segment in segments {
            segmentedControl.insertSegment(withTitle: segment.title, at: segment.rawValue, animated: false)
        }
        
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        guard let selectedSegment = Segment(rawValue: segmentedControl.selectedSegmentIndex) else {
            fatalError("It must not happen")
        }
        segmentDelegate?.didSelect(segment: selectedSegment)
    }
    
}
