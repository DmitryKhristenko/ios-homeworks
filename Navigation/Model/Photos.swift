//
//  Photos.swift
//  Navigation
//
//  Created by Дмитрий Х on 05.04.23.
//

import UIKit

struct Photos {
    
    static func makePhotosModel() -> [UIImage] {
        var photosArray = [UIImage()]
        for i in 1...19 {
            if let image = UIImage(named: "p\(i)") {
                photosArray.append(image)
            }
        }
        return photosArray
    }
    
}
