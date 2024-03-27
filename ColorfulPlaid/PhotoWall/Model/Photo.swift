//
//  Photo.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation

struct Photo: Decodable {
    /// e.g. "https://via.placeholder.com/150/92c952"
    let thumbnailUrl: URL

    /// e.g. "https://via.placeholder.com/600/92c952"
    let url: URL

    /// e.g. 1
    let albumId: Int

    /// e.g. 1
    let id: Int

    /// e.g. "accusamus beatae ad facilis cum similique qui sunt"
    let title: String
}

extension Photo {
    
    static func loadTestPhotos() -> [Photo] {
        
        guard let fileUrl = Bundle.main.url(forResource: "photos", withExtension: "json") else {
            fatalError("File not found")
        }

        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            let photos = try decoder.decode([Photo].self, from: data)
            return photos
        } catch {
            return []
        }
    }
}
