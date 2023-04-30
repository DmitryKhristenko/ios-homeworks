//
//  AnimationForImage.swift
//  Navigation
//
//  Created by Dimitry Khristenko on 27.04.2023.
//

import UIKit

struct AnimationForImage {
    
    var initialImageRect: CGRect = .zero
    
    var crossButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .systemGray2
        button.alpha = 0
        return button
    }()
    
    var animatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var blurView: UIVisualEffectView = {
        return $0
    }(UIVisualEffectView())
    
    // MARK: - Methods
    
    func animateImage(_ image: UIImage?, imageFrame: CGRect, view: UIView,
                      imageHeight: CGFloat, getCornerRadius: @escaping() -> CGFloat) {
        let blurEffect = UIBlurEffect(style: .regular)
        blurView.effect = blurEffect
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        [blurView, animatingImageView, crossButton].forEach { view.addSubview($0) }
        setupConstraintsForAnimation(view: view)
        
        animatingImageView.image = image
        animatingImageView.alpha = 1.0
        animatingImageView.frame = CGRect(x: imageFrame.origin.x,
                                          y: imageFrame.origin.y,
                                          width: imageFrame.width,
                                          height: imageFrame.height)
        
        UIView.animate(withDuration: 0.5) {
            blurView.alpha = 1.0
            animatingImageView.frame.size = CGSize(width: UIScreen.main.bounds.width - 10,
                                                   height: imageHeight)
            animatingImageView.center = view.center
            let animatingImageViewCornerRadius = getCornerRadius()
            if animatingImageViewCornerRadius == self.animatingImageView.frame.width / 2 {
                animatingImageView.layer.cornerRadius = self.animatingImageView.frame.width / 2
            } else {
                animatingImageView.layer.cornerRadius = animatingImageViewCornerRadius
            }
        } completion: { _ in
            UIView.animate(withDuration: 0.01) {
                crossButton.layer.cornerRadius = self.crossButton.frame.width / 2
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    crossButton.alpha = 1
                }
            }
        }
    }
    
    func animateImageToInitial(rect: CGRect, view: UIView) {
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            animatingImageView.frame = rect
        } completion: { _ in
            animatingImageView.removeFromSuperview()
        }
    }
    
    private func setupConstraintsForAnimation(view: UIView) {
        NSLayoutConstraint.activate([
            crossButton.widthAnchor.constraint(equalToConstant: 40),
            crossButton.heightAnchor.constraint(equalToConstant: 40),
            crossButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            crossButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
}
