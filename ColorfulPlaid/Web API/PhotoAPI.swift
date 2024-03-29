//
//  PhotoAPI.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation
import DolphinHTTP

final class PhotoAPI: DataLoader {
    
    private let loader: HTTPLoader
    private let url: URL
    
    init(url: URL, loader: HTTPLoader = URLSessionLoader(session: URLSession.shared)) {
        self.url = url
        self.loader = loader
    }
    
    func load(completion: @escaping((Result<SuccessResponse, FailureResponse>) -> Void)) {
        var r = HTTPRequest(scheme: url.scheme ?? "https")
        r.host = url.host
        r.path =  url.path
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
