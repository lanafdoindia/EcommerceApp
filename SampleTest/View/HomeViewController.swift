//
//  HomeViewconViewController.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    
    lazy var homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchHomeLayout()
        viewModel.dispatchGroup.notify(queue: .main) {
            self.homeTableView.reloadData()
        }
    }
    
    private func setupView() {
        view.addSubview(homeTableView)
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            homeTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            homeTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        registerCells()
    }
    
    private func registerCells() {
        homeTableView.register(HorizontalListTableCell.self, forCellReuseIdentifier: String(describing: HorizontalListTableCell.self))
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.homeDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fragment = viewModel.homeDataList[indexPath.row]
        switch fragment.type {
        case .category, .products, .banners:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HorizontalListTableCell.self), for: indexPath) as? HorizontalListTableCell {
                cell.templateType = fragment.type
                cell.values = fragment.values
                return cell
            }
        default:
            return UITableViewCell(frame: .zero)
        }
        return UITableViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let fragment = viewModel.homeDataList[indexPath.row]
        switch fragment.type {
        case .category:
            return 90
        case .products:
            return 200
        case .banners:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView.init(frame: CGRect(x: 0, y: 0, width: 0.0, height: 0.0))
        viewHeader.backgroundColor = .clear
        return viewHeader
    }
     
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let viewFooter = UIView.init(frame: CGRect(x: 0, y: 0, width: 0.0, height: 0.0))
         viewFooter.backgroundColor = .clear
         return viewFooter
     }
}
