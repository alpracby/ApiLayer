//
//  NetworkError.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public enum NetworkError: Error {
    case connection
    case invalidData
    case custom(reason: String, title: String? = nil)
    
    public var title: String? {
        switch self {
        case .connection, .invalidData:
            return nil
        case .custom(_, let title):
            return title
        }
    }
    
    public var localizedDescription: String {
        switch self {
        case .connection:
            return "No Internet Connection Error"
        case .invalidData:
            return "Invalid Data"
        case .custom(let error, _):
            return error
        }
    }
}
