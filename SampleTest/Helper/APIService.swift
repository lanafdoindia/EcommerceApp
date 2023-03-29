//
//  APIService.swift
//  SampleTest
//
//  Created by Lana Fernando S on 28/03/23.
//

import UIKit

final class APIService {
    
    static let shared = APIService()
    
    func getService<T: Decodable>(urlString: String, completion: @escaping (_ response: T?) -> ()) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completion(nil)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(T.self, from: data)
                    completion(model)
                } catch let error {
                    print("Error: ", error)
                    completion(nil)
                }
            }
            task.resume()
        }
    }
    
    func downloadImage(urlString: String, completion: @escaping (_ response: UIImage?) -> ()) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                completion(UIImage(data: data))
            }
            task.resume()
        }
    }
}
