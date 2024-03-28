//
//  MainQueueDispatchDecorator.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/28.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let component: T
    
    init(component: T) {
        self.component = component
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainQueueDispatchDecorator: DataLoader where T: DataLoader {
    
    func load(completion: @escaping ((Result<SuccessResponse, FailureResponse>) -> Void)) {
        
        component.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: ImageDataLoader where T: ImageDataLoader {
    
    func load(url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> URLSessionTask? {
        
        component.load(url: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
