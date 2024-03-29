//
//  ImageDataLoader.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/29.
//

import UIKit

protocol ImageDataLoader {
    typealias Result = Swift.Result<UIImage, Error>
    func load(url: URL, completion: @escaping (Result) -> Void) -> URLSessionTask?
}
