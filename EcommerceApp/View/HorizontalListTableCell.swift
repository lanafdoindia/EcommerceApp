//
//  HorizontalListTableCell.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import UIKit

class HorizontalListTableCell: UITableViewCell {
    
    var templateType: HomeViewType?
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    var values: [HomeValue] = [] 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        values = []
        horizontalCollectionView.reloadData()
    }
    
    private func configure(){
        self.registerCells()
        contentView.addSubview(containerView)
        containerView.addSubview(horizontalCollectionView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            horizontalCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            horizontalCollectionView.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: 0)
        ])
        self.horizontalCollectionView.reloadData()
    }
    
    private func registerCells() {
        horizontalCollectionView.register(HomeCategoryCollectionCell.self, forCellWithReuseIdentifier: String(describing: HomeCategoryCollectionCell.self))
        horizontalCollectionView.register(HomeBannerCollectionCell.self, forCellWithReuseIdentifier: String(describing: HomeBannerCollectionCell.self))
        horizontalCollectionView.register(ProductCollectionCell.self, forCellWithReuseIdentifier: String(describing: ProductCollectionCell.self))
    }
}

extension HorizontalListTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let value = values[indexPath.section]
        switch self.templateType {
        case .category:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCategoryCollectionCell.self), for: indexPath) as? HomeCategoryCollectionCell {
                cell.value = value
                return cell
            }
        case .banners:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeBannerCollectionCell.self), for: indexPath) as? HomeBannerCollectionCell {
                cell.value = value
                return cell
            }
        case .products:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCollectionCell.self), for: indexPath) as? ProductCollectionCell {
                cell.value = value
                return cell
            }
        default:
            break
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCategoryCollectionCell.self), for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.templateType {
        case .category:
            return  CGSize(width: 78, height: 80)
        case .banners:
            return  CGSize(width: UIScreen.main.bounds.width - 50, height: 150)
        case .products:
            return  CGSize(width: 120, height: 200)
        default:
            break
        }
        return  CGSize(width: 78, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
}
