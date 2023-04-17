//
//  BaseErrorModel.swift
//  
//
//  Created by Alper ACABEY on 14.04.2023.
//

import Foundation

public struct BaseErrorModel: Decodable {
    let statusMessage: String?
    let statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
