//
//  PostEntity+CoreDataProperties.swift
//  Navigation
//
//  Created by Dimitry Khristenko on 30.04.2023.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var image: String?
    @NSManaged public var isLiked: Bool
    @NSManaged public var likes: Int32
    @NSManaged public var postDescription: String?
    @NSManaged public var urlToWebPage: String?
    @NSManaged public var views: Int32

}

extension PostEntity : Identifiable {

}
