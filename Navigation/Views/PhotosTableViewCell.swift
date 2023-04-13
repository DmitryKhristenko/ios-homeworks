//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий Х on 05.04.23.
//

import UIKit

protocol PhotosTableViewCellDelegate {
    func pushPhotosVC()
}

final class PhotosTableViewCell: UITableViewCell {
    
    static var delegate: PhotosTableViewCellDelegate?
    
    private lazy var photosLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.text = "Photos"
        return $0
    }(UILabel())
    
    private lazy var arrowButton: UIButton = {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("→", for: .normal)
        $0.addTarget(self, action: #selector(arrowButtonPressed), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var horizontalCollectionView = makeCollectionView(scrollDirection: .horizontal)
    
    private lazy var photos = Photos.makePhotosModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.isPagingEnabled = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func arrowButtonPressed() {
        PhotosTableViewCell.delegate?.pushPhotosVC()
    }
    
    private func setupView() {
        [photosLabel, arrowButton, horizontalCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false;
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            horizontalCollectionView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: arrowButton.trailingAnchor)
            
        ])
    }
    
}

// MARK: - UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell
        cell?.setupCell(index: indexPath.item)
        return cell ?? UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat { 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = horizontalCollectionView.bounds.height - sideInset
        let width = (horizontalCollectionView.bounds.width - sideInset * 5) / 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: .zero, left: sideInset, bottom: .zero, right: sideInset)
    }
        
}
