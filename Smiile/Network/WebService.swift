//
//  WebService.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

import Alamofire

class WebService {
    
    static func configure () {
        
        var headers = HTTPHeaders()
        // Si besoin auth
        //        if let accessToken = UserService.accessToken {
        //            headers["Authorization"] = "Token token=" + accessToken
        //        }
        headers["os"] = "iOS"
        headers["os-version"] = UIDevice.current.systemVersion
        headers["app-version"] = AppVersion
        headers["locale"] = currentUsableLocale
        headers["timezone"] = TimeZone.current.identifier
        
        Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders = headers
    }
    
    static internal func request (_ method: HTTPMethod, path: String, params: Parameters?, json: Bool = false, completion: @escaping ((Error?, [String : AnyObject]) -> Void)) {
        
        var url = Configuration.ApiBaseUrl
        if path.hasPrefix("/") {
            url += path
        }
        else {
            url += "/" + path
        }
        
        debugPrint("API: \(path)")
        debugPrint("Params: \(String(describing: params))")
        Alamofire.request(url,
                          method: method,
                          parameters: params,
                          encoding: (json ? JSONEncoding.default : URLEncoding.default)).responseJSON { response in
                            
                            self.process(response, completion: completion)
        }
    }
    
    static internal func process (_ response: DataResponse<Any>, completion: ((Error?, [String : AnyObject]) -> Void)) {
        let emptyResponse = [String: AnyObject]()
        
        if let result = response.result.value as? [String : AnyObject] {
            //Adapt to the WS in order to fit the response fields
            if let errorMessage = result["error"] as? String {
                let error: Error
                error = SmiileError.API(errorCode: "", displayMessage: errorMessage)
                completion(error, emptyResponse)
            }
            completion(nil, result)
        }
        else if let error = response.result.error {
            completion(error, emptyResponse)
        }
        else {
            completion(SmiileError.Generic(), emptyResponse)
        }
    }
    
}
