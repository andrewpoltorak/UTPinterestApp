//
//  NetworkService.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import PinterestSDK
import ViewControllerAuthorization

func PinterestLogin() {
    PDKClient.sharedInstance().authenticateWithPermissions([PDKClientReadPublicPermissions,PDKClientReadPublicPermissions,PDKClientReadRelationshipsPermissions,PDKClientWritePublicPermissions,PDKClientWritePublicPermissions,PDKClientWriteRelationshipsPermissions], fromViewController: ViewControllerAuthorization, withSuccess: {
        (success :PDKResponseObject!) -> Void in let user = success.user()
        print(user.identifier);
        print(user.image?.url);
        print(user.username);
        print(user.firstName);
        print(user.lastName);
        print(user.biography);
        print(user.largestImage().url)
        print(user.smallestImage().url) }) {
            (error: NSError!) -> Void in print(error.description) }
    
}

func PinterestLogout() {
    PDKClient.clearAuthorizedUser()
}

