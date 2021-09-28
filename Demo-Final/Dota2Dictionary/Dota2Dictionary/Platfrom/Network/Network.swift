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

extension String {
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}

extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            if value is String {
                let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            } else {
                return "\(percentEscapedKey)=\(value)"
            }
        }
        return parameterArray.joined(separator: "&")
    }
}

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
            if let paramString = param?.stringFromHttpParameters() {
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
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200, let res = response {
                    print(res)
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
    
    /// call data from https://api.opendota.com/api/heroes
    func getHeroAll(closure: @escaping (_ response: [HeroModel]?, _ error: Error?) -> Void) {
        requestSON("https://api.opendota.com/api/heroes",
                   param: nil,
                   method: .GET,
                   loading: true) { (data, _) in
            if let data = data as? [[String: Any]] {
                var listHero: [HeroModel] = [HeroModel]()
                for item in data {
                    let listHeroAdd: HeroModel = HeroModel()
                    listHeroAdd.initLoad(item)
                    listHero.append(listHeroAdd)
                }
                closure(listHero, nil)
            } else {
                closure(nil, nil)
            }
        }
    }
    
}
