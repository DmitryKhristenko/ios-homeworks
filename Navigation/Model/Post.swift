//
//  Post.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit

struct Post {

    var author: String
    var postDescription: String
    var image: String
    var likes: Int
    var views: Int
    var urlToWebPage: String
    var isLiked: Bool
    
    static func makePostModel() -> [[Post]] {
        var model = [[Post]]()
        var section = [Post]()
        section.append(Post(author: "NASA, CSA", postDescription: "NASA объявило экипаж первого пилотируемого полета к Луне по программе «Артемида.", image: "post1", likes: 144, views: 1459, urlToWebPage: "https://nplus1.ru/news/2023/04/03/artemis-2-crew", isLiked: false))
        section.append(Post(author: "The University of Western Australia", postDescription: "На глубине 8336 метров у берегов Японии обнаружили самую глубоководную рыбу", image: "post2", likes: 432, views: 10004, urlToWebPage: "https://nplus1.ru/news/2023/04/03/very-deep-fish", isLiked: false))
        section.append(Post(author: "Марат Хамадеев, Полина Лосева", postDescription: "Константы и переменные. Какую физику использует BioShock Infinite", image: "post3", likes: 283, views: 2459, urlToWebPage: "https://nplus1.ru/material/2023/03/24/bioshock-infinite-10", isLiked: false))
        section.append(Post(author: "ISRO", postDescription: "Индия успешно посадила прототип крылатой первой ступени многоразовой ракеты", image: "post4", likes: 323, views: 4503, urlToWebPage: "https://nplus1.ru/news/2023/04/03/rlv-td-fly", isLiked: false))
        model.append(section)
        return model
    }
}
