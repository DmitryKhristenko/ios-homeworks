//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Дмитрий Х on 12.04.23.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    func setupCell(index: Int) {
        photoImageView.image = UIImage(named: "p\(index + 1)")
        photoImageView.layer.cornerRadius = 6
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
}
