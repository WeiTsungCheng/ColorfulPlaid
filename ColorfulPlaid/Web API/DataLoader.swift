//
//  DataLoader.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/29.
//

import Foundation
import DolphinHTTP

protocol DataLoader {
    func load(completion: @escaping((Result<SuccessResponse, FailureResponse>) -> Void))
}

struct SuccessResponse {
    
    enum SuccessType {
        case ok
        case normal(content: Codable)
    }
    
    let statusCode: Int?
    let type: SuccessType
    
    let description: String?
    let detail: String?
    
    init(statusCode: Int?, type: SuccessType, description: String? = nil, detail: String? = nil) {
        self.statusCode = statusCode
        self.type = type
        self.description = description
        self.detail  = detail
    }
}

struct FailureResponse: Error {
    
    enum ErrorType {
        case httpError(HTTPError)
        case noResponseBody
        case parsingFailed
        case severError
        case clientError
        case notDefinedError
        case other(Error)
    }
    
    let statusCode: Int?
    let type: ErrorType
    
    let description: String?
    let detail: String?
    
    init(statusCode: Int?, type: ErrorType, description: String? = nil, detail: String? = nil) {
        self.statusCode = statusCode
        self.type = type
        self.description = description
        self.detail  = detail
    }
}
