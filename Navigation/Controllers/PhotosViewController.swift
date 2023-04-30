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
    private var animation = AnimationForImage()
    
    // MARK: - View
    
    private lazy var verticalScrollCollectionView = makeCollectionView(scrollDirection: .vertical)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        animation.crossButton.addTarget(self, action: #selector(crossButtonAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(UIDevice.orientationDidChangeNotification)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Private Methods
    
    @objc private func crossButtonAction() {
        UIView.animate(withDuration: 0.3) {
            self.animation.crossButton.alpha = 0
            self.animation.animateImageToInitial(rect: self.animation.initialImageRect, view: self.view)
        } completion: { _ in
            self.animation.crossButton.removeFromSuperview()
            UIView.animate(withDuration: 0.2) {
                self.animation.blurView.alpha = 0.1
            } completion: { _ in
                self.animation.blurView.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
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

// MARK: - ImageAnimationDelegate
extension PhotosViewController: ImageAnimationDelegate {
    
    func didTapImage(_ image: UIImage?, imageRect: CGRect) {
        
        let rect = view.frame
        let currentCollectionRect = verticalScrollCollectionView.convert(rect, to: view)
        animation.initialImageRect = CGRect(x: imageRect.origin.x,
                                            y: imageRect.origin.y + currentCollectionRect.origin.y,
                                            width: imageRect.width,
                                            height: imageRect.height)
        animation.animateImage(image, imageFrame: animation.initialImageRect, view: view, imageHeight: verticalScrollCollectionView.collectionViewLayout.collectionViewContentSize.height / 2) {
            10
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell
        cell?.setupPhotoCell(index: indexPath.item)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = photosModel[indexPath.item]
        guard let itemImageRect = verticalScrollCollectionView.cellForItem(at: indexPath)?.frame else { return }
        didTapImage(selectedImage, imageRect: itemImageRect)
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
