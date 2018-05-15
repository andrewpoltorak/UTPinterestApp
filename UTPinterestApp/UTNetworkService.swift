//
//  NetworkService.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 24.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import PinterestSDK

class UTNetworkService {

    //MARK: Properties
    
    var user = PDKUser()
    var accessToken = ""
    
    
    //MARK: Metods
    
    func authenticateUser() {
        let viewControllerAuthorization = ViewControllerAuthorization()
        PDKClient.sharedInstance().authenticate(withPermissions: [PDKClientReadPublicPermissions,PDKClientWritePublicPermissions,PDKClientReadRelationshipsPermissions,PDKClientWriteRelationshipsPermissions], from: viewControllerAuthorization, withSuccess: { (PDKResponseObject) in
            self.accessToken = PDKClient.sharedInstance().oauthToken
        }, andFailure: {
            (Error) in
            print("Please try again...")
        })
    }
    
    func userData() -> String {
        var greetingWithName: String!
        let parameters: [String : String] = ["fields": "first_name,id,last_name,url,image,username,bio,counts,created_at,account_type"]
        PDKClient.sharedInstance().getPath("/v1/me/", parameters: parameters, withSuccess: {
            (PDKResponseObject) in
            self.user = (PDKResponseObject?.user())!
            greetingWithName = "Welcome " + (PDKResponseObject?.user().firstName)! + " " + (PDKResponseObject?.user().lastName != nil ? (PDKResponseObject?.user().lastName)! : "")
        }) {
            (Error) in
            print("Try again...")
        }
        return greetingWithName
    }
}
