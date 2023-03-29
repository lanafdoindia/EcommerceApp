//
//  HomeModel.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import Foundation

enum HomeViewType: String, Decodable {
    case category, banners, products
}

class HomeValue: Decodable {
    var id: Int
    var name: String?
    var imageUrl: String?
    var image: String?
    var bannerUrl: String?
    var actualPrice: String?
    var offerPrice: String?
    var offer: Int?
    var isExpress: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case image
        case bannerUrl = "banner_url"
        case actualPrice = "actual_price"
        case offerPrice = "offer_price"
        case offer
        case isExpress = "is_express"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        bannerUrl = try container.decodeIfPresent(String.self, forKey: .bannerUrl)
        actualPrice = try container.decodeIfPresent(String.self, forKey: .actualPrice)
        offerPrice = try container.decodeIfPresent(String.self, forKey: .offerPrice)
        offer = try container.decodeIfPresent(Int.self, forKey: .offer)
        isExpress = try container.decodeIfPresent(Bool.self, forKey: .isExpress)
    }
}

class HomeDataModel: Decodable {
    var type: HomeViewType?
    var values: [HomeValue]
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case values = "values"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(HomeViewType.self, forKey: .type)
        values = try container.decodeIfPresent([HomeValue].self, forKey: .values) ?? []
    }
}

class HomeLayoutModel: Decodable {
    var status: Bool
    var homeData: [HomeDataModel]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case homeData = "homeData"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(Bool.self, forKey: .status) ?? false
        homeData = try container.decodeIfPresent([HomeDataModel].self, forKey: .homeData) ?? []
    }
}
