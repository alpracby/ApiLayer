//
//  ApiConfigurationProtocol.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public protocol ApiConfigurationProtocol {
    var baseUrl: String { get }
    var headers: [String: String] { get }
}
