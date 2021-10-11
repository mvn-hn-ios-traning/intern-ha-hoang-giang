//
//  NetworkPlus.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ItemAPIService {
    
    static let shared = ItemAPIService()
    
    func parse(jsonData: Data) -> Observable<[String]> {
        return Observable.create { observer -> Disposable in
            do {
                let decodedData = try JSONDecoder().decode(ItemModel.self,
                                                           from: jsonData)
                observer.onNext(decodedData.array.sorted())
            } catch {
                print("decode error")
            }
            return Disposables.create()
        }
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
