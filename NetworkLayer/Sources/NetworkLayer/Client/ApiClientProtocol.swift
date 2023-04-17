//
//  ApiClientProtocol.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public protocol ApiClientProtocol {
    var restClient: RestClient { get }
    
    var isReachable: Bool { get }
    
    init(restClient: RestClient)
    
    @discardableResult
    func execute<Task: NetworkTask>(task: Task, result: @escaping (Result<Task.ResponseModel?, NetworkError>) -> Void) -> URLSessionDataTask?
    
    func success<Task: NetworkTask>(response: ResponseDataModel, task: Task, result: @escaping (Result<Task.ResponseModel?, NetworkError>) -> Void) throws
    
    func failure<Task: NetworkTask>(response: ResponseDataModel, task: Task, result: @escaping (Result<Task.ResponseModel?, NetworkError>) -> Void) throws
}
