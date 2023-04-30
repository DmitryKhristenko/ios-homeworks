//
//  HeartButton.swift
//  Navigation
//
//  Created by Dimitry Khristenko on 25.04.2023.
//

import UIKit

final class HeartButton: UIButton {
    
    private let unlikedImage = UIImage(named: "heart_empty")
    private let likedImage = UIImage(named: "heart_filled")
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3
    
    private let postEntity = PostEntity(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(unlikedImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flipLikedState(isLiked: Bool) {
        animate(isHeartLiked: isLiked)
    }
    
    func setUnlikedImage() {
        setImage(unlikedImage, for: .normal)
    }
    
    private func animate(isHeartLiked: Bool) {
        print("animate = \(isHeartLiked)")
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
