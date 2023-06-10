//
//  HomeCategoryCollectionCell.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import UIKit

class HomeCategoryCollectionCell: UICollectionViewCell {
    
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
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = .systemCyan
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        containerView.addSubview(titleLabel)
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
            productImageView.widthAnchor.constraint(equalToConstant: 50),
            productImageView.heightAnchor.constraint(equalToConstant: 50),
            productImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func updateValue() {
        if let value = value {
            titleLabel.text = value.name ?? ""
            setImage()
        }
    }
    
    private func setImage() {
        if let value = value, let imageUrl = value.imageUrl {
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
