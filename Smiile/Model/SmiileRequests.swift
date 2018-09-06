//
//  SmiileRequests.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import ObjectMapper

// For Demo only same attributes as SmiileServices, SmiileObjects
class SmiileRequests: Mappable {
    var id: Int?
    var title: String?
    var content: String?
    var imageString: String?
    var tag: SmiileTag?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["title"]
        content         <- map["content"]
        imageString     <- map["image_url"]
        tag             <- map["tag"]
    }
}
