//
//  HomeViewModel.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import Foundation

class HomeViewModel {
    
    var homeDataList: [HomeDataModel] = []
    var dispatchGroup = DispatchGroup()
    
    func fetchHomeLayout() {
        dispatchGroup.enter()
        APIService.shared.getService(urlString: "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0") { [weak self] (response: HomeLayoutModel?) in
            if let response = response {
                self?.homeDataList = response.homeData
            }
            self?.dispatchGroup.leave()
        }
    }
}
