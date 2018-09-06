//
//  Configuration.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import Foundation
import KeychainAccess

struct Configuration {
    
    #if DEVELOPMENT
    static let productionMode = false
    #else
    static let productionMode = true
    #endif

    static let appDelegate = UIApplication.shared.delegate as! AppDelegate

    static var ApiBaseUrl : String {
        return productionMode ? "URL API PROD" : "URL API DEV"
    }
    
    static var keychain: Keychain {
        return productionMode ? Keychain(service: "com.thomasdonninger.Smiile") : Keychain(service: "com.thomasdonninger.Smiile-Dev")
    }
    
    static let FacebookPermissions = ["public_profile", "email", "user_friends", "user_birthday"]
}

enum SmiileError: Error {
    
    case API(errorCode: String, displayMessage: String?)
    case Generic()
    case Parsing()
    case Silent()
    
    var displayMessage: String? {
        switch self {
        case .API( _, let displayMessage):
            return displayMessage
        default:
            return nil
        }
    }
    
}
