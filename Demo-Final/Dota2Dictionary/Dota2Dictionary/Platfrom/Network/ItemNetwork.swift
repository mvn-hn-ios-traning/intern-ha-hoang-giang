//
//  ItemNetwork.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Item
class ItemAPIService {
    
    static let shared = ItemAPIService()
    
    func parse(jsonData: Data) -> [String]? {
            do {
                let decodedData = try JSONDecoder().decode(ItemModel.self,
                                                           from: jsonData)
                return decodedData.array.sorted()
            } catch {
                print("decode error")
            }
        return nil
    }
    
    func loadJson(fromURLString urlString: String,
                  completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, _, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
}
