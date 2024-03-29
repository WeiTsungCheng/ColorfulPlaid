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
    
    private lazy var loadingActivityIndicatorContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var loadingActivityIndicatorView: UIActivityIndicatorView = {
        let idv = UIActivityIndicatorView(style: .large)
        idv.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return idv
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
        
        view.addSubview(loadingActivityIndicatorContainerView)
        loadingActivityIndicatorContainerView.addSubview(loadingActivityIndicatorView)
        
        loadingActivityIndicatorContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingActivityIndicatorContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingActivityIndicatorContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingActivityIndicatorContainerView.widthAnchor.constraint(equalToConstant: 65),
            loadingActivityIndicatorContainerView.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        loadingActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingActivityIndicatorView.centerXAnchor.constraint(equalTo: loadingActivityIndicatorContainerView.centerXAnchor),
            loadingActivityIndicatorView.centerYAnchor.constraint(equalTo: loadingActivityIndicatorContainerView.centerYAnchor),
            loadingActivityIndicatorView.widthAnchor.constraint(equalToConstant: 60),
            loadingActivityIndicatorView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func bind() {
        title = viewModel?.title
        viewModel?.onLoading = { [weak self] isLoading in
            if isLoading {
                self?.startLoadingAnimation()
            } else {
                self?.stopLoadingAnimation()
            }
        }
    }
    
    func generateLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalWidth(1/4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func startLoadingAnimation() {
        loadingActivityIndicatorContainerView.isHidden = false
        loadingActivityIndicatorView.startAnimating()
    }
    
    private func stopLoadingAnimation() {
        loadingActivityIndicatorContainerView.isHidden = true
        loadingActivityIndicatorView.stopAnimating()
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
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cellController(forItemAt: indexPath)
        cell.cancelLoad()
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
