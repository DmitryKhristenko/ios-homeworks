//
//  Photos.swift
//  Navigation
//
//  Created by Дмитрий Х on 05.04.23.
//

import UIKit


struct Photos {
    static func makePhotosModel() -> [UIImage] {
        var photosArray = [UIImage]()
        let photoNames = ["p0", "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10", "p11", "p12", "p13", "p14", "p15", "p16", "p17", "p18", "p19"]
        for photoName in photoNames {
            if let image = UIImage(named: photoName) {
                photosArray.append(image)
            }
        }
        return photosArray
    }
    
}
