//
//  UICollectionCell+CellIdentifier.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import UIKit

extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
