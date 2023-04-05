//
//  Extensions.swift
//  Navigation
//
//  Created by Дмитрий Х on 29.03.23.
//

import UIKit

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

extension UIColor {
    convenience init?(hex: String) {
        let r, g, b: CGFloat
        let offset = hex.hasPrefix("#") ? 1 : 0
        let start = hex.index(hex.startIndex, offsetBy: offset)
        let hexColor = String(hex[start...])
        guard hexColor.count == 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return nil
        }
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            self.init(red: r, green: g, blue: b, alpha: 1)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return nil
        }
    }
}

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
}

