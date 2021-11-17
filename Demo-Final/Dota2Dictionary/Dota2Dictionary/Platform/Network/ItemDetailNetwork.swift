//
//  ItemDetailNetwork.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: Item Detail
class ItemDetailAPIService {
    
    static let shared = ItemDetailAPIService()
    
    func parse(itemKey: String, jsonData: Data) -> ItemDetailModel? {
            do {
                let decodedData = try JSONDecoder().decode(ItemDetailDecodeArray.self,
                                                           from: jsonData)
                let arayINeed = decodedData
                    .array
                    .filter {
                        $0.itemKey == itemKey
                    }
                if let elementINeed = arayINeed.first {
                    return elementINeed
                }
            } catch {
                print("error: ", error)
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
