//
//  SectionService.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import ObjectMapper

class SectionService: WebService {

    // Demo Only - generate fake sections
    static func getFakeSections(completion: @escaping ((Error?, [SmiileSection]?) -> Void)) {
        if let fakeJson = readJsonFile("fakeSections") as? [String : AnyObject] {
            if let sections = Mapper<SmiileSection>().mapArray(JSONObject: fakeJson["sections"]) {
                completion(nil, sections)
            } else {
                completion(SmiileError.Parsing(), nil)
            }
        }
    }
}
