//
//  HomeCategoryCollectionCell.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private var flatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var deliveryIconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "express_delivery")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var offerPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        return button
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
        value = nil
    }
    
    private func configure() {
        containerView.addSubview(flatLabel)
        containerView.addSubview(productImageView)
        containerView.addSubview(stackView)
        containerView.addSubview(deliveryIconImageView)
        stackView.addArrangedSubview(offerPriceLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(titleLabel)
        containerView.addSubview(addButton)
        
        contentView.addSubview(containerView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            flatLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            flatLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            flatLabel.heightAnchor.constraint(equalToConstant: 25),
            
            productImageView.topAnchor.constraint(equalTo: flatLabel.bottomAnchor, constant: 5),
            productImageView.widthAnchor.constraint(equalToConstant: 50),
            productImageView.heightAnchor.constraint(equalToConstant: 50),
            productImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            deliveryIconImageView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 0),
            deliveryIconImageView.widthAnchor.constraint(equalToConstant: 20),
            deliveryIconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: deliveryIconImageView.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 15),
            addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    func updateValue() {
        if let value = value {
            titleLabel.text = value.name ?? ""
            if let flat = value.offer, flat > 0 {
                flatLabel.text = "\(flat)% OFF"
            } else {
                flatLabel.isHidden = true
            }
            let offerPrice = value.offerPrice ?? ""
            let offerPriceInt = Int(offerPrice.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
            let actualPrice = value.actualPrice ?? ""
            if !offerPrice.isEmpty, offerPriceInt > 0, offerPrice != actualPrice {
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: offerPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                offerPriceLabel.attributedText = attributeString
            } else {
                offerPriceLabel.isHidden = true
            }
            if let actualPrice = value.actualPrice {
                priceLabel.text = actualPrice
            }
            deliveryIconImageView.isHidden = !(value.isExpress ?? false)
            setImage()
        }
    }
    
    private func setImage() {
        if let value = value, let imageUrl = value.image {
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
