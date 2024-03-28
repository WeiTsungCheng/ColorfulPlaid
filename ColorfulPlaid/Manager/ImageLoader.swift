//
//  ImageLoader.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation
import UIKit

protocol ImageDataLoader {
    typealias Result = Swift.Result<UIImage, Error>
    func load(url: URL, completion: @escaping (Result) -> Void) -> URLSessionTask?
}

final class ImageLoader: ImageDataLoader {
    
    struct HTTPError: Error {
        let code: Code
        enum Code {
            case noData
        }
    }
    
    static let shared = ImageLoader()
    
    let imageCache = NSCache<NSURL, UIImage>()
    
    typealias Result = Swift.Result<UIImage, Error>
    
    func load(url: URL, completion: @escaping (Result) -> Void) -> URLSessionTask? {
        
        if let image = imageCache.object(forKey: url as NSURL) {
            completion(.success(image))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url as NSURL)
                completion(.success(image))
                
            } else {
                if let error = error {
                    completion(.failure(error))
                }
                completion(.failure(HTTPError(code: .noData)))
            }
        }
        
        task.resume()
        
        return task
    }
    
}

