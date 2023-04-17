//
//  ResponseDataModel.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public struct ResponseDataModel {
    public let statusCode: Int
    public let data: Data?
    public let error: Error?
    public let request: URLRequest?
    
    /// Initializer for success responses
    init(statusCode: Int, data: Data, request: URLRequest?) {
        self.statusCode = statusCode
        self.data = data
        self.error = nil
        self.request = request
    }
    
    /// Initializer for failed responses
    init(statusCode: Int, error: Error, request: URLRequest?) {
        self.statusCode = statusCode
        self.data = nil
        self.error = error
        self.request = request
    }
    
    /// Generic initializer
    init(statusCode: Int, data: Data?, error: Error?, request: URLRequest?) {
        self.statusCode = statusCode
        self.data = data
        self.error = error
        self.request = request
    }
}

public extension ResponseDataModel {
    var isSuccess: Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}
