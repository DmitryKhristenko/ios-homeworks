//
//  HeartButton.swift
//  Navigation
//
//  Created by Dimitry Khristenko on 25.04.2023.
//

import UIKit

final class HeartButton: UIButton {
    
    // MARK: - Properties
    
    private let unlikedImage = UIImage(named: "heart_empty")
    private let likedImage = UIImage(named: "heart_filled")
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(unlikedImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setImage(isLikedImage: Bool) {
        isLikedImage ? setImage(likedImage, for: .normal) : setImage(unlikedImage, for: .normal)
    }
    
    func flipLikedState(isLiked: Bool) {
        animate(isHeartLiked: isLiked)
    }
    
    private func animate(isHeartLiked: Bool) {
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = isHeartLiked ? self.likedImage : self.unlikedImage
            let newScale = isHeartLiked ? self.likedScale : self.unlikedScale
            self.transform = self.transform.scaledBy(x: newScale, y: newScale)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
    
}
