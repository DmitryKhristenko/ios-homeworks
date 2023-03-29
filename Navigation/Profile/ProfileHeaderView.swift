//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Х on 21.03.23.
//

import UIKit

final class ProfileHeaderView: UIView {
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: "cat")
        v.roundedImage()
        v.contentMode = .scaleAspectFit
        v.layer.borderWidth = 3.0
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.masksToBounds = false
        return v
    }()
    private lazy var headingLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Hipster Cat"
        v.font = UIFont.boldSystemFont(ofSize: 18)
        return v
    }()
    private lazy var statusLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Waiting for something"
        v.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        v.textColor = .gray
        return v
    }()
    private lazy var statusTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.placeholder = "type here"
        v.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        v.textColor = .black
        v.backgroundColor = .white
        v.setLeftPaddingPoints(5)
        v.layer.borderWidth = 1.0
        v.layer.cornerRadius = 12.0
        v.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return v
    }()
    private lazy var statusButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemBlue
        v.setTitle("Set status", for: .normal)
        v.layer.cornerRadius = 4.0
        v.layer.shadowOffset.height = 4.0
        v.layer.shadowOffset.width = 4.0
        v.layer.shadowRadius = 4.0
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.7
        v.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        return v
    }()
    private var statusText: String?
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.roundedImage()
    }
    private func setupView() {
        addSubview(imageView)
        addSubview(headingLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(statusButton)
        clipsToBounds = true
        setupConstraints()
    }
    @objc private func statusButtonPressed() {
        if statusTextField.text != "" {
            statusLabel.text = statusTextField.text
            statusTextField.text = ""
        } else {
            statusLabel.text = "Waiting for something"
        }
        print("statusLabel.text = \(String(describing: statusLabel.text))")
    }
    @objc private func statusTextChanged() {
        statusText = statusTextField.text
        print("statusText = \(String(describing: statusText))")
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            headingLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            statusLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 12),
            statusTextField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            statusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
