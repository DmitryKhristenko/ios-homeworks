//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Х on 21.03.23.
//

import UIKit

final class ProfileHeaderView: UIView {
    private lazy var avatarImageView: UIImageView = {
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
    private lazy var fullNameLabel: UILabel = {
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
    private lazy var setStatusButton: UIButton = {
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
        avatarImageView.roundedImage()
    }
    private func setupView() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
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
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 125),
            avatarImageView.heightAnchor.constraint(equalToConstant: 125),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 12),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
