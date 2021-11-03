//
//  Network.swift
//  Dota2Dictionary
//
//  Created by MacOS on 26/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

typealias ApiCompletion = (_ data: Any?, _ error: Error?) -> Void
typealias ApiParam = [String: Any]

enum ApiMethod: String {
    case GET = "get"
    case POST = "post"
}

// MARK: - Patch and Hero API
class Network: NSObject {
    static let shared: Network = Network()
    func requestSON(_ url: String,
                    param: ApiParam?,
                    method: ApiMethod,
                    loading: Bool,
                    completion: @escaping ApiCompletion) {
        var request: URLRequest!
        
        // set method & param
        if method == .GET {
            if let paramString = param {
                request = URLRequest(url: URL(string: "\(url)?\(paramString)")!)
            } else {
                request = URLRequest(url: URL(string: url)!)
            }
        } else if method == .POST {
            request = URLRequest(url: URL(string: url)!)
            
            // content-type
            let headers: Dictionary = ["Content-Type": "application/json"]
            request.allHTTPHeaderFields = headers
            
            do {
                if let paramm = param {
                    request.httpBody = try JSONSerialization.data(withJSONObject: paramm, options: .prettyPrinted)
                }
            } catch { }
        }
        
        request.timeoutInterval = 30
        request.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                // check for fundamental networking error
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                
                // check for http errors
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200, response != nil {
                }
                if let resJson = self.convertToJson(data) {
                    completion(resJson, nil)
                } else if let resString = String(data: data, encoding: .utf8) {
                    completion(resString, error)
                } else {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    private func convertToJson(_ byData: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: byData, options: [])
        } catch {}
        return nil
    }
    
    // get Patch data
    func getPatchAll(closure: @escaping (_ response: [PatchModel]?, _ error: Error?) -> Void) {
        requestSON("https://raw.githubusercontent.com/odota/dotaconstants/master/build/patchnotes.json",
                   param: nil,
                   method: .GET,
                   loading: true) { (data, _) in
            if let data = data as? [String: Any] {
                let sortedPatches = Array(data.keys).sorted(by: >)
                var listPatch: [PatchModel] = [PatchModel]()
                for patch in sortedPatches {
                    let listPatchAdd: PatchModel = PatchModel()
                    listPatchAdd.patchName = patch
                    if let details = data[patch] as? [String: Any] {
                        if let general = details["general"] as? [String] {
                            listPatchAdd.general = general
                        }
                    }
                    listPatch.append(listPatchAdd)
                }
                closure(listPatch, nil)
            } else {
                closure(nil, nil)
            }
        }
    }
    
    // get Items and Heroes Patch Data
    func getHeroesDetailAll(patchName: String,
                            closure: @escaping (_ response: [PatchModel]?, _ error: Error?) -> Void) {
        requestSON("https://raw.githubusercontent.com/odota/dotaconstants/master/build/patchnotes.json",
                   param: nil,
                   method: .GET,
                   loading: true) { (data, _) in
            if let data = data as? [String: Any] {
                var listPatch: [PatchModel] = [PatchModel]()
                if let details = data[patchName] as? [String: Any] {
                    if let heroes = details["heroes"] as? [String: Any] {
                        let sortHeroes = Array(heroes.keys).sorted(by: <)
                        for hero in sortHeroes {
                            let listPatchAdd: PatchModel = PatchModel()
                            listPatchAdd.imageKey = "heroes"
                            listPatchAdd.sizeImg = "full"
                            listPatchAdd.nameHeroItem = hero
                            if let heroDetail = heroes[hero] as? [String] {
                                listPatchAdd.detailHeroItem = heroDetail
                            }
                            listPatch.append(listPatchAdd)
                        }
                    }
                }
                closure(listPatch, nil)
            } else {
                closure(nil, nil)
            }
        }
    }
    
    func getItemsDetailAll(patchName: String,
                           closure: @escaping (_ response: [PatchModel]?, _ error: Error?) -> Void) {
        requestSON("https://raw.githubusercontent.com/odota/dotaconstants/master/build/patchnotes.json",
                   param: nil,
                   method: .GET,
                   loading: true) { (data, _) in
            if let data = data as? [String: Any] {
                var listPatch: [PatchModel] = [PatchModel]()
                if let details = data[patchName] as? [String: Any] {
                    if let items = details["items"] as? [String: Any] {
                        let sortItems = Array(items.keys).sorted(by: >)
                        for item in sortItems {
                            let listPatchAdd: PatchModel = PatchModel()
                            listPatchAdd.imageKey = "items"
                            listPatchAdd.sizeImg = "lg"
                            listPatchAdd.nameHeroItem = item
                            if let itemDetail = items[item] as? [String] {
                                listPatchAdd.detailHeroItem = itemDetail
                            }
                            listPatch.append(listPatchAdd)
                        }
                    }
                }
                closure(listPatch, nil)
            } else {
                closure(nil, nil)
            }
        }
    }
    
    // get Hero All Data
    func getHeroAll(closure: @escaping (_ response: [HeroModel]?, _ error: Error?) -> Void) {
        requestSON("https://raw.githubusercontent.com/odota/dotaconstants/master/build/hero_names.json",
                   param: nil,
                   method: .GET,
                   loading: true) { (data, _) in
            if let data = data as? [String: Any] {
                var listHero: [HeroModel] = [HeroModel]()
                let sortedHeroesAll = Array(data.keys).sorted(by: <)
                for hero in sortedHeroesAll {
                    let listHeroAdd = HeroModel()
                    listHeroAdd.name = hero
                    if let heroProperties = data[hero] as? [String: Any] {
                        if let heroID = heroProperties["id"] as? Int {
                            listHeroAdd.heroID = heroID
                        }
                        if let primaryAttr = heroProperties["primary_attr"] as? String {
                            listHeroAdd.primaryAttr = primaryAttr
                        }
                    }
                    listHero.append(listHeroAdd)
                }
                closure(listHero, nil)
            } else {
                closure(nil, nil)
            }
        }
    }
}

// MARK: - Hero Detail
class HeroDetailAPISevice {
    
    static let shared = HeroDetailAPISevice()
    
    func parse(heroID: String, jsonData: Data) -> Observable<HeroDetailModel> {
        return Observable.create { observer -> Disposable in
            do {
                let decodedData = try JSONDecoder().decode(HeroDetailDecodeArray.self,
                                                           from: jsonData)
                let arrayINeed = decodedData.array.filter {
                    $0.heroID == heroID
                }
                if let elementINeed = arrayINeed.first {
                    observer.onNext(elementINeed)
                }
            } catch {
                print("parseAll error: ", error)
            }
            return Disposables.create()
        }
    }
    
    func parseRoles(jsonData: Data) -> Observable<[RolesDetail]> {
        return Observable.create { (observer) -> Disposable in
            do {
                let decodedData = try JSONDecoder().decode([RolesDetail].self, from: jsonData)
                observer.onNext(decodedData)
                print(decodedData)
            } catch {
                print("parseRoles error: ", error)
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

// MARK: - Item
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

// MARK: Item Detail
class ItemDetailAPIService {
    
    static let shared = ItemDetailAPIService()
    
    func parse(itemKey: String, jsonData: Data) -> Observable<ItemDetailModel> {
        return Observable.create { observer -> Disposable in
            do {
                let decodedData = try JSONDecoder().decode(ItemDetailDecodeArray.self,
                                                           from: jsonData)
                let arayINeed = decodedData
                    .array
                    .filter {
                        $0.itemKey == itemKey
                    }
                if let elementINeed = arayINeed.first {
                    observer.onNext(elementINeed)
                }
            } catch {
                print("error: ", error)
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
