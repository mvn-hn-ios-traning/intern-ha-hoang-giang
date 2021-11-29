//
//  HeroDetailNetwork.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Hero Detail
class HeroDetailAPISevice {
    
    static let shared = HeroDetailAPISevice()
    
    func parseInfo(heroID: String, jsonData: Data) -> HeroDetailModel? {
        do {
            let decodedData = try JSONDecoder().decode(HeroDetailDecodeArray.self,
                                                       from: jsonData)
            let arrayINeed = decodedData.array.filter {
                $0.heroID == heroID
            }
            if let elementINeed = arrayINeed.first {
                return elementINeed
            }
        } catch {
            print("parseAll error: ", error)
        }
        return nil
    }
    
    func parseAbility(heroNameOriginal: String, jsonData: Data) -> HeroAbilityMidman? {
        do {
            let decodedData = try JSONDecoder().decode(AbilityDecodeArray.self, from: jsonData)
            let arrayINeed = decodedData.array.filter {
                $0.heroName == heroNameOriginal
            }
            if let elementINeed = arrayINeed.first {
                return elementINeed
            }
        } catch {
            print("error: ", error)
        }
        return nil
    }
    
    func parseHeroAbilities(jsonData: Data) -> [HeroDetailAbilitiesModel]? {
        do {
            let decodedData = try JSONDecoder().decode(HeroAbilitiesArratDecoded.self, from: jsonData)
            return decodedData.array
        } catch {
            print("error: ", error)
        }
        return nil
    }
    
    func parseLores(jsonData: Data) -> [String: String]? {
        do {
            let decodedData = try JSONDecoder().decode([String: String].self, from: jsonData)
            return decodedData
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
