//
//  NetworkTask.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public protocol NetworkTask {
    associatedtype RequestModel: Codable
    associatedtype ResponseModel: Codable
    
    var endpoint: String? { get }
    var httpMethod: HTTPMethodType { get }
    var request: RequestModel { get }
    var fullServiceUrl: String? { get }
    
    init(fullServiceUrl: String?, request: RequestModel)
}

public extension NetworkTask {
    var fullServiceUrl: String? { nil }
    
    init(fullServiceUrl: String? = nil, request: RequestModel) {
        self.init(fullServiceUrl: fullServiceUrl, request: request)
    }
}
