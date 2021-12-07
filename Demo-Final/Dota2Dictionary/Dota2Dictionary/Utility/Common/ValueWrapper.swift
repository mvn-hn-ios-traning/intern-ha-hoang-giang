//
//  ValueWrapper.swift
//  ADKATech.com
//
//  Created by Amr Elghadban on 9/20/18.
//  Copyright © 2018 Mobile DevOps. All rights reserved.
//
import Foundation

enum ValueWrapper: Codable {
    case stringValue(String)
    case stringArray([String])
    case intValue(Int)
    case doubleValue(Double)
    case boolValue(Bool)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .stringValue(value)
            return
        }
        if let value = try? container.decode([String?].self) {
            self = .stringArray(value.compactMap {$0})
            return
        }
        if let value = try? container.decode(Bool.self) {
            self = .boolValue(value)
            return
        }
        if let value = try? container.decode(Double.self) {
            self = .doubleValue(value)
            return
        }
        if let value = try? container.decode(Int.self) {
            self = .intValue(value)
            return
        }

        throw DecodingError.typeMismatch(ValueWrapper.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Wrong type for ValueWrapper"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .stringValue(value):
            try container.encode(value)
        case let .stringArray(value):
            try container.encode(value)
        case let .boolValue(value):
            try container.encode(value)
        case let .intValue(value):
            try container.encode(value)
        case let .doubleValue(value):
            try container.encode(value)
        }
    }

    var rawValue: String {
        var result: String
        switch self {
        case let .stringValue(value):
            result = value
        case let .stringArray(value):
            result = (value.first ?? "") + ", " + (value.last ?? "")
        case let .boolValue(value):
            result = String(value)
        case let .intValue(value):
            result = String(value)
        case let .doubleValue(value):
            result = String(value)
        }
        return result
    }
    
    var mccdValue: String {
        var result: String
        switch self {
        case let .stringValue(value):
            result = value
        case let .stringArray(value):
            if value.count == 3 {
                let firstExpression = (value.first ?? "0") + "/" + value[1]
                let secondExpression = value[2]
                result = firstExpression  + "/" + secondExpression
            } else {
                let firstExpression = (value.first ?? "0") + "/" + value[1]
                let secondExpression = value[2] + "/" + (value.last ?? "")
                result = firstExpression  + "/" + secondExpression
            }
        case let .boolValue(value):
            result = String(value)
        case let .intValue(value):
            result = String(value)
        case let .doubleValue(value):
            result = String(value)
        }
        return result
    }
    
    var rawArray: [String] {
        var result: [String]
        switch self {
        case let .stringValue(value):
            result = [String](arrayLiteral: value)
        case let .stringArray(value):
            result = value
        case let .boolValue(value):
            result = [String](arrayLiteral: String(value))
        case let .intValue(value):
            result = [String](arrayLiteral: String(value))
        case let .doubleValue(value):
            result = [String](arrayLiteral: String(value))
        }
        return result
    }

    var intValue: Int? {
        var result: Int?
        switch self {
        case let .stringValue(value):
            result = Int(value)
        case let .stringArray(value):
            result = Int(value.first ?? "0")
        case let .intValue(value):
            result = value
        case let .boolValue(value):
            result = value ? 1 : 0
        case let .doubleValue(value):
            result = Int(value)
        }
        return result
    }

    var boolValue: Bool? {
        var result: Bool?
        switch self {
        case let .stringValue(value):
            result = Bool(value)
        case let .stringArray(value):
            result = Bool(value.first ?? "true")
        case let .boolValue(value):
            result = value
        case let .intValue(value):
            result = Bool(truncating: value as NSNumber)
        case let .doubleValue(value):
            result = Bool(truncating: value as NSNumber)
        }
        return result
    }
}
