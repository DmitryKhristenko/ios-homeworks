//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 12.04.23.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    // MARK: - Properties
    
    private var photosModel = Photos.makePhotosModel()
    
    // MARK: - View
    
    private lazy var verticalScrollCollectionView = makeCollectionView(scrollDirection: .vertical)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(UIDevice.orientationDidChangeNotification)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Private Methods
    
    @objc private func orientationDidChange() {
        verticalScrollCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Photo Gallery"
        verticalScrollCollectionView.dataSource = self
        verticalScrollCollectionView.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(verticalScrollCollectionView)
        
        NSLayoutConstraint.activate([
            verticalScrollCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalScrollCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            verticalScrollCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            verticalScrollCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell
        cell?.setupCell(index: indexPath.item)
        return cell ?? UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeForItem = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: sizeForItem, height: sizeForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
}
