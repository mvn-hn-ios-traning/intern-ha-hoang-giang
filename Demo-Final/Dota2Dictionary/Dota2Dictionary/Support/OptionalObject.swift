//
//  OptionalObject.swift
//  Dota2Dictionary
//
//  Created by MacOS on 14/10/2021.
//

import Foundation

public struct OptionalObject<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}
