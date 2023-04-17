//
//  EncodableExtension.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
