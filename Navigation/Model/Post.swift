//
//  Post.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit

struct Post {

    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
    
    static func makePostModel() -> [[Post]] {
        var model = [[Post]]()
        var section = [Post]()
        section.append(Post(author: "NASA, CSA", description: "NASA объявило экипаж первого пилотируемого полета к Луне по программе «Артемида.", image: "post1", likes: 144, views: 1459))
        section.append(Post(author: "The University of Western Australia", description: "На глубине 8336 метров у берегов Японии обнаружили самую глубоководную рыбу", image: "post2", likes: 432, views: 10004))
        section.append(Post(author: "Марат Хамадеев, Полина Лосева", description: "Константы и переменные. Какую физику использует BioShock Infinite", image: "post3", likes: 283, views: 2459))
        section.append(Post(author: "ISRO", description: "Индия успешно посадила прототип крылатой первой ступени многоразовой ракеты", image: "post4", likes: 323, views: 4503))
        model.append(section)
        return model
    }
}
