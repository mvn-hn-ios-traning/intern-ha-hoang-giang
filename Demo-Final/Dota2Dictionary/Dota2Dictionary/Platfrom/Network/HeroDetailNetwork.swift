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
    
    func parse(heroID: String, jsonData: Data) -> HeroDetailModel? {
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
    
    func parseRoles(jsonData: Data) -> [RolesDetail]? {
        do {
            let decodedData = try JSONDecoder().decode([RolesDetail].self, from: jsonData)
            return decodedData
        } catch {
            print("parseRoles error: ", error)
        }
        return nil
    }
    
    func parseAbilityId(jsonData: Data) -> [String: String]? {
        do {
            let decodedData = try JSONDecoder().decode([String: String].self, from: jsonData)
            return decodedData
        } catch {
            print("error: ", error)
        }
        return nil
    }
    
    func parseHeroAbilities(jsonData: Data) -> [HeroDetailAbilitiesModel]? {
        do {
            let decodedData = try JSONDecoder().decode(HeroAbilitiesArratDecoded.self, from: jsonData)
            print(decodedData.array.filter { $0.abilitiesKey == "antimage_mana_break" })
            return decodedData.array
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
