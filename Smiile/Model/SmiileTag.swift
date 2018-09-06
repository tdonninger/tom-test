//
//  SmiileTag.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import ObjectMapper

class SmiileTag: Mappable {
    var id: Int?
    var name: String?
    // Good Idea ? Users can remeber a color for a specific section
    //var colorHex: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        //colorHex        <- map["color_hexa"]
    }
}
