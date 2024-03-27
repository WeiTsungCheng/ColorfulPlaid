//
//  PhotoWallViewController.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import UIKit

final class PhotoWallViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let clv = UICollectionView(frame:.zero, collectionViewLayout: generateLayout())
        clv.dataSource = self
        clv.prefetchDataSource = self
        clv.delegate = self
        clv.register(PhotoBlockCollectionViewCell.self, forCellWithReuseIdentifier: PhotoBlockCollectionViewCell.cellIdentifier())
        return clv
    }()
    
    var collectionModel = [PhotoBlockCellController]() {
        didSet { collectionView.reloadData() }
    }
    
    var viewModel: PhotoWallViewModel? {
        didSet {
            bind()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadPhotos()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bind() {
        title = viewModel?.title
    }
    
    func generateLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalWidth(1/4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
}

extension PhotoWallViewController: UICollectionViewDelegate {
    
}

extension PhotoWallViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellController(forItemAt: indexPath).view(in: collectionView, at: indexPath)
    }
    
}

extension PhotoWallViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            cellController(forItemAt: indexPath).preload()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            cancelCellControllerLoad(forItemAt: indexPath)
        }
    }
}

extension PhotoWallViewController {
    
    private func cellController(forItemAt indexPath: IndexPath) -> PhotoBlockCellController {
        return collectionModel[indexPath.item]
    }
    
    private func cancelCellControllerLoad(forItemAt indexPath: IndexPath) {
        cellController(forItemAt: indexPath).cancelLoad()
    }
}
