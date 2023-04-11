//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit

final class PostViewController: UIViewController {
    
    var titlePost: String = "Post"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createBarItem()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        self.navigationItem.title = titlePost
    }
    
    private func createBarItem() {
        let barItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc private func buttonTapped() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }
    
}
