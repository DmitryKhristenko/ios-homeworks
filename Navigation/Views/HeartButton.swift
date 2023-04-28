//
//  HeartButton.swift
//  Navigation
//
//  Created by Dimitry Khristenko on 25.04.2023.
//

import UIKit

final class HeartButton: UIButton {
    
    private var isLiked = false
    private let unlikedImage = UIImage(named: "heart_empty")
    private let likedImage = UIImage(named: "heart_filled")
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3
    
    private let postEntity = PostEntity(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
    
    var someof: [PostEntity]?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
//        do {
//            someof = try postEntity.managedObjectContext?.fetch(PostEntity.fetchRequest())
//
//        } catch {
//
//        }
//        if someof?.first?.isLiked == false {
//
//            setImage(unlikedImage, for: .normal)
//        } else {
//            setImage(likedImage, for: .normal)
//        }
        setImage(unlikedImage, for: .normal)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flipLikedState() -> Bool {
        isLiked = !isLiked
        animate()
        return isLiked
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = self.isLiked ? self.likedImage : self.unlikedImage
            let newScale = self.isLiked ? self.likedScale : self.unlikedScale
            self.transform = self.transform.scaledBy(x: newScale, y: newScale)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
    
}
