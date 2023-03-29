//
//  HomeCategoryCollectionCell.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import UIKit

class HomeBannerCollectionCell: UICollectionViewCell {
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var value: HomeValue? {
        didSet {
            updateValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configure() {
        containerView.addSubview(productImageView)
        contentView.addSubview(containerView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            productImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            productImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func updateValue() {
        setImage()
    }
    
    private func setImage() {
        if let value = value, let imageUrl = value.bannerUrl {
            APIService.shared.downloadImage(urlString: imageUrl) { [weak self] response in
                if let response = response {
                    DispatchQueue.main.async {
                        self?.productImageView.image = response
                    }
                }
            }
        }
    }
}
