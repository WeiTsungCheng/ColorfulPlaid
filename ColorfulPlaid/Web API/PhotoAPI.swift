//
//  PhotoAPI.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation
import DolphinHTTP

final class PhotoAPI {
    
    private let loader: HTTPLoader
    
    init(loader: HTTPLoader = URLSessionLoader(session: URLSession.shared)) {
        self.loader = loader
    }
    
    func loadNews(completion: @escaping((Result<SuccessResponse, FailureResponse>) -> Void)) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com")!
        var r = HTTPRequest(scheme: url.scheme ?? "https")
        r.host = url.host
        r.port = url.port
        r.path = "/photos"
        r.method = .get
        
        loader.load(request: r) { result in
            
            switch result {
            case.failure(let error):
                completion(.failure(FailureResponse(statusCode: nil, type: .httpError(error))))
                
            case .success(let response):
                guard let data = response.body else {
                    completion(.failure(FailureResponse(statusCode: response.status.rawValue, type: .noResponseBody)))
                    return
                }
                
                switch response.status {
                case .success, .create:
                    let decoder = JSONDecoder()
                    
                    do {
                        let items = try decoder.decode([Photo].self, from: data)
                        let successResponse = SuccessResponse(statusCode: response.status.rawValue, type: .normal(content: items))
                        completion(.success(successResponse))
                        
                    } catch {
                        completion(.failure(FailureResponse(statusCode: response.status.rawValue, type: .parsingFailed)))
                    }
                    
                case .badRequest, .unauthorized, .forbidden, .notFound, .methodNotAllowed:
                    completion(.failure(FailureResponse(statusCode: response.status.rawValue, type: .clientError)))
                    
                case .serverError:
                    completion(.failure(FailureResponse(statusCode: response.status.rawValue, type: .severError)))
                    
                default:
                    completion(.failure(FailureResponse(statusCode: response.status.rawValue, type: .notDefinedError)))
                }
                
            }
            
        }
    }
    
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
