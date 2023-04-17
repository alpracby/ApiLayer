//
//  ApiClient.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public class ApiClient: ApiClientProtocol {
    
    private enum Constant {
        enum Text {
            static let unknownError: String = "Beklenmedik bir hata oluştu!"
        }
    }
    
    public var restClient: RestClient
    
    public var isReachable: Bool {
        return restClient.isReachable
    }
    
    public required init(restClient: RestClient) {
        self.restClient = restClient
    }
    
    @discardableResult
    public func execute<Task: NetworkTask>(task: Task, result: @escaping (Result<Task.ResponseModel?, NetworkError>) -> Void) -> URLSessionDataTask? {
        
        guard isReachable else {
            result(.failure(.connection))
            return nil
        }

       return restClient.execute(task: task) { [weak self] data in
            if data.isSuccess {
                do {
                    try self?.success(response: data, task: task, result: result)
                } catch {
                    result(.failure(NetworkError.custom(reason: error.localizedDescription, title: nil)))
                }
            }
            else {
                do {
                    try self?.failure(response: data, task: task, result: result)
                }catch {
                    
                    result(.failure(NetworkError.custom(reason: Constant.Text.unknownError, title: nil)))
                }
            }
        }
    }
    
    public func success<Task: NetworkTask>(response: ResponseDataModel, task: Task, result: @escaping (Result<Task.ResponseModel?, NetworkError>) -> Void) throws {
        guard let data = response.data else {
            result(.failure(.invalidData))
            return
        }
        
        let responseModel = try JSONDecoder().decode(Task.ResponseModel.self, from: data)
        
        result(.success(responseModel))
    }
    
    public func failure<Task: NetworkTask>(response: ResponseDataModel, task: Task, result: @escaping (Result<Task.ResponseModel?, NetworkError>) -> Void) throws {
        
        guard let data = response.data else {
            result(.failure(.invalidData))
            return
        }
    
        let errorModel = try JSONDecoder().decode(BaseErrorModel.self, from: data)
        
        result(.failure(.custom(reason: errorModel.statusMessage ?? Constant.Text.unknownError, title: "Hata: \(errorModel.statusCode ?? -1)")))
    }
}


//
//curl 'https://browsingpublic.trendyol.com/mobile-zeus-zeus-service/widget/display/personalized?widgetPageName=interview&platform=iphone' \
//-H 'Host: browsingpublic.trendyol.com' \
//-H 'Build: 217' \
//-H 'Platform: iphone' \
//-H 'Accept: */*' \
//-H 'Accept-Language: en-US,en;q=0.9' \
//-H 'User-Agent: ListingApp/1 CFNetwork/1406.0.4 Darwin/22.4.0' \
//-H 'Connection: keep-alive' \
//-H 'Content-Type: application/json' \
//--cookie '__cflb=02DiuFagyyXRM6JdWqTmoB4bJNy8amQPjNmE2LScFXskG' \
//--proxy http://localhost:9090
