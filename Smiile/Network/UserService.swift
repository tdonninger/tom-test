//
//  UserService.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import FBSDKLoginKit
import ObjectMapper

class UserService: WebService {
    
    //MARK: Variables
    static var accessToken : String?
    static var currentUser : SmiileUser?

    private static let accessTokenKey = "accessToken"
    private static let userKey = "user"

    //MARK: Functions
    // Get the FacebookToken
    static func loginWithFacebook (_ viewController: UIViewController, completion: @escaping ((Error?, SmiileUser?) -> Void)) {
        
        // Demo Only - Start
        UserService.getFakeUser(completion: { (error, user) in
            if let error = error {
                completion(error as Error?, nil)
            }
            else {
                completion(nil, user)
            }
        })
        // Demon Only - End
        
        /*
        // http://stackoverflow.com/questions/29408299/ios-facebook-sdk-4-0-login-error-code-304
        FBSDKLoginManager().logOut()
        
        FBSDKLoginManager().logIn(withReadPermissions: Configuration.FacebookPermissions, from: viewController, handler: { (result, error) -> Void in
            if let error = error {
                debugPrint("Facebook login error: \(error)")
                completion(error as Error?, nil)
            }
            else if (result?.isCancelled)! {
                debugPrint("Facebook login cancelled")
                completion(SmiileError.Generic(), nil)
            }
            else {
                // Retrieve user infos with fb token
                //self.login((result?.token.tokenString)!, completion: completion)
            }
        })
        */
    }
    
    // Log the user with the facebook token in order to retrieve his/her infos
    /*
    private static func login (_ facebookToken: String, completion: @escaping ((Error?, User?) -> Void)) {
    
            let params = ["facebook_token": facebookToken]
            self.request(.post, path: "/login", params: params as [String : AnyObject]?, completion: { (error, response) -> Void in
                if let error = error {
                    completion(error, nil)
                }
                else if let accessToken = response["access_token"] as? String,
                    let user = Mapper<User>().map(JSONObject: response["user"]) {
                    self.accessToken = accessToken
                    self.currentUser = user
                    self.saveAccessTokenAndUser()
                    completion(nil, self.currentUser)
                }
                else {
                    completion(SmiileError.Parsing(), nil)
                }
            })
        }
     */
    
    // Demo Only - generate fake user
    static func getFakeUser(completion: @escaping ((Error?, SmiileUser?) -> Void)) {
        if let fakeJson = readJsonFile("fakeUser") as? [String : AnyObject] {
            if let accessToken = fakeJson["access_token"] as? String, let user = Mapper<SmiileUser>().map(JSONObject: fakeJson["user"]) {
                self.accessToken = accessToken
                self.currentUser = user
                self.saveAccessTokenAndUser()
                completion(nil, user)
            } else {
                completion(SmiileError.Parsing(), nil)
            }
        }
    }
    
    // Save Access Token and User
    static func saveAccessTokenAndUser () {
        Configuration.keychain[self.accessTokenKey] = self.accessToken
        Configuration.keychain[self.userKey] = self.currentUser?.toJSONString()
    }
    
    // Reload User
    static func autoConnect() -> Bool {
        if let accessToken = Configuration.keychain[self.accessTokenKey],
            let userJSON = Configuration.keychain[self.userKey],
            let user = Mapper<SmiileUser>().map(JSONString: userJSON) {
            self.accessToken = accessToken
            self.currentUser = user
            return true
        }
        return false
    }
}
