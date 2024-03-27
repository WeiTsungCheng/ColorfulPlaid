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
    let albumId: String

    /// e.g. 1
    let id: String

    /// e.g. "accusamus beatae ad facilis cum similique qui sunt"
    let title: String
}
