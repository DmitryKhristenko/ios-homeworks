//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private var post = Post(title: "Post")
    
    private lazy var verticalStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addArrangedSubview(buttonOne)
        $0.addArrangedSubview(buttonTwo)
        $0.axis = .vertical
        $0.spacing = 10.0
        return $0
    }(UIStackView())
    
    private lazy var buttonOne: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 0/255, green: 173/255, blue: 181/255, alpha: 1.0)
        $0.layer.cornerRadius = 13
        $0.setTitle("First button", for: .normal)
        $0.setTitleColor(UIColor(red: 227/255, green: 253/255, blue: 253/255, alpha: 1.0), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var buttonTwo: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 100/255, green: 155/255, blue: 225/255, alpha: 1.0)
        $0.layer.cornerRadius = 13
        $0.setTitle("Second button", for: .normal)
        $0.setTitleColor(UIColor(red: 227/255, green: 253/255, blue: 253/255, alpha: 1.0), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 227/255, green: 253/255, blue: 253/255, alpha: 1.0)
        view.addSubview(verticalStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.widthAnchor.constraint(equalToConstant: 170),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
