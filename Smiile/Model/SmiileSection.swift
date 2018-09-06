//
//  SmiileSection.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import ObjectMapper

enum SectionType: String {
    case news = "news"
    case objects = "objects"
    case services = "services"
    case requests = "requests"
}

class SmiileSection: Mappable {
    var id: Int?
    var type: SectionType?
    var name: String?
    var news: [SmiileNews]?
    var adverts: [SmiileAdverts]?
    // if needed we can create distinct object to handle format properly
    //    var objects: [SmiileObjects]?
    //    var services: [SmiileServices]?
    //    var requests: [SmiileRequests]?
    var currentPage: Int = 1
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        type            <- map["type"]
        name            <- map["name"]
        news            <- map["news"]
        adverts         <- map["adverts"]
    }
    
    //MARK: Helper
    var numberOfElements: Int {
        if let news = self.news {
            return news.count
        } else if let adverts = self.adverts {
            return adverts.count
        }
        
        return 0
    }
    
    func newsAtIndex(_ index: Int) -> SmiileNews? {
        guard let news = news, news.count != 0, index < news.count else { return nil }
        return news[index]
    }
    
    func advertsAtIndex(_ index: Int) -> SmiileAdverts? {
        guard let adverts = adverts, adverts.count != 0, index < adverts.count else { return nil }
        return adverts[index]
    }
}
