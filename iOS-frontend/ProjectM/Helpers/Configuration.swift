//
//  Configuration.swift
//  ProjectM
//
//  Created by Bryan on 1/12/22.
//
import Foundation

// Helps you get values from Info.plist, provide the key of the item and the value will be retured
enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
            case let value as T:
                return value
            case let string as String:
                guard let value = T(string) else { fallthrough }
                return value
            default:
                throw Error.invalidValue
        }
    }
}
