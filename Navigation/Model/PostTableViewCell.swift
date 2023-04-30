//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий Х on 04.04.23.
//

import UIKit

protocol HeartButtonDelegate: AnyObject {
    func changeLikesCounter(index: Int)
}

final class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let context = PostEntity(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContext)
    
    static weak var heartButtonDelegate: HeartButtonDelegate?
    
    private lazy var contentWhiteView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    lazy var authorLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var postImageView: UIImageView = {
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    lazy var descriptionLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .gray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var likesLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return $0
    }(UILabel())
    
    lazy var viewsLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return $0
    }(UILabel())
    
    lazy var heartButton = HeartButton()
    
    var indexForCounter = 0
    
    var buttonTapCallback: (() -> ())?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        heartButton.addTarget(self, action: #selector(handleHeartButtonTap(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupPostCell(model: PostEntity, isAnimated: Bool) {
        guard let safeImage = model.image else { return }
        
        authorLabel.text = model.author
        postImageView.image = UIImage(named: safeImage)
        descriptionLabel.text = model.postDescription
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
        isAnimated ? heartButton.flipLikedState(isLiked: model.isLiked) : model.isLiked ? heartButton.setImage(isLikedImage: true) : heartButton.setImage(isLikedImage: false)
    }
    
    @objc private func handleHeartButtonTap(_ sender: UIButton) {
        buttonTapCallback?()
    }
    
    private func setupView() {
        [contentWhiteView, authorLabel, postImageView, descriptionLabel, likesLabel, heartButton, viewsLabel].forEach { contentView.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            
            contentWhiteView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            contentWhiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -5),
            authorLabel.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: -5),
            
            postImageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: likesLabel.topAnchor, constant: -15),
            
            likesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -10),
            
            heartButton.heightAnchor.constraint(equalToConstant: 32),
            heartButton.widthAnchor.constraint(equalToConstant: 32),
            heartButton.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 5),
            heartButton.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor),
            
            viewsLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -10)
        ])
    }
    
}
