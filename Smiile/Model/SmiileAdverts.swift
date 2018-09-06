//
//  SmiileAdverts.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import ObjectMapper

enum AdertType: String {
    case object = "object"
    case service = "service"
    case request = "request"
}

// For Demo only same attributes as SmiileServices, SmiileRequests
class SmiileAdverts: Mappable {
    var id: Int?
    var title: String?
    var content: String?
    var city: String?
    var price: String?
    var imageString: String?
    var tag: SmiileTag?
    var user: SmiileUser?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["title"]
        content         <- map["content"]
        city            <- map["city"]
        price           <- map["price"]
        imageString     <- map["image_url"]
        tag             <- map["tag"]
        user            <- map["user"]
    }
}
