//
//  SmiileUser.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import ObjectMapper
import UIKit

class SmiileUser: Mappable {
    var id: String?
    var firstname: String?
    var lastname: String?
    var email: String?
    var imageString: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        // do the mapping according to the WS specifications
        id              <- map["id"]
        firstname       <- map["firstname"]
        lastname        <- map["lastname"]
        email           <- map["email"]
        imageString     <- map["image_url"]
    }
}
