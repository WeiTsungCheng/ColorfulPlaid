//
//  PhotoBlockCellController.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation
import UIKit

final class PhotoBlockCellController {
    
    private let viewModel: PhotoBlockCellViewModel
    private var cell: PhotoBlockCollectionViewCell?
    
    init(viewModel: PhotoBlockCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = binded(collectionView.dequeueReusableCell(for: indexPath))
        
        return cell
    }
    
    private func binded(_ cell: PhotoBlockCollectionViewCell) -> PhotoBlockCollectionViewCell {
        self.cell = cell
        cell.idLabel.text = "\(viewModel.id)"
        cell.titleLabel.text = viewModel.title
        
        return cell
    }
    
}
