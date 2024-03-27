//
//  PhotoBlockCollectionViewCell.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import UIKit

final class PhotoBlockCollectionViewCell: UICollectionViewCell {
    
    lazy var photoImageView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(systemName: "photo")
        return imv
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stv = UIStackView()
        stv.axis = .vertical
        stv.alignment = .center
        stv.distribution = .fillProportionally
        stv.spacing = 4
        return stv
    }()
    
    lazy var idLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "id"
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "title"
        lbl.textColor = .black
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .blue
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        photoImageView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor)
        ])
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStackView.addArrangedSubview(idLabel)
        verticalStackView.addArrangedSubview(titleLabel)
    }
    
}
