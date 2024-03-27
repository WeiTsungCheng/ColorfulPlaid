//
//  ViewController.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/26.
//

import UIKit

final class HomeViewController: UIViewController {
    
    lazy var photoWallButton: UIButton = {
        
        let btn = UIButton(type: .system)
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Photo Wall"
        configuration.baseForegroundColor = .black
        configuration.background.backgroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        btn.configuration = configuration
        
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 4
        
        btn.addTarget(self, action: #selector(gotoPhotoWall), for: .touchUpInside)
        
        return btn
    }()
    
    var viewModel: HomeViewModel? {
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
        view.addSubview(photoWallButton)
        
        photoWallButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoWallButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoWallButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    private func bind() {
        title  = viewModel?.title
    }
    
    @objc func gotoPhotoWall(_ sender: UIButton) {
        viewModel?.navigateToNextPage?()
    }
    
}

