//
//  NetworkService.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 24.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import PinterestSDK

class NetworkService {

    //MARK: Properties
    
    var viewControllerAuthorization = ViewControllerAuthorization()
    
    //MARK: Metods
    
    func authenticateUser() {
        PDKClient.sharedInstance().authenticate(withPermissions: [PDKClientReadPublicPermissions,PDKClientWritePublicPermissions,PDKClientReadRelationshipsPermissions,PDKClientWriteRelationshipsPermissions], from: self.viewControllerAuthorization, withSuccess: { (PDKResponseObject) in
            self.viewControllerAuthorization.activityIndicator.stopAnimating()
            self.viewControllerAuthorization.accessToken = PDKClient.sharedInstance().oauthToken
            self.userData()
        }, andFailure: {
            (Error) in
            self.viewControllerAuthorization.view.isUserInteractionEnabled = true
            self.viewControllerAuthorization.startLabel.text = "Please try again..."
            self.viewControllerAuthorization.activityIndicator.stopAnimating()
        })
    }
    
    func userData() {
        let parameters: [String : String] = ["fields": "first_name,id,last_name,url,image,username,bio,counts,created_at,account_type"]
        PDKClient.sharedInstance().getPath("/v1/me/", parameters: parameters, withSuccess: {
            (PDKResponseObject) in
            var viewControllerPersonalData = ViewControllerPersonalData()
            viewControllerPersonalData = self.viewControllerAuthorization.story.instantiateViewController(withIdentifier: "ViewControllerPersonalData") as! ViewControllerPersonalData
            self.viewControllerAuthorization.navigationController!.pushViewController(viewControllerPersonalData, animated: true)
            self.viewControllerAuthorization.user = (PDKResponseObject?.user())!
            _ = viewControllerPersonalData.view
            viewControllerPersonalData.greetingLabel.text = "Welcome " + (PDKResponseObject?.user().firstName)! + " " + (PDKResponseObject?.user().lastName != nil ? (PDKResponseObject?.user().lastName)! : "")
        }) {
            (Error) in
            self.viewControllerAuthorization.view.isUserInteractionEnabled = true
            self.viewControllerAuthorization.startLabel.text = "Try again..."
            self.viewControllerAuthorization.activityIndicator.stopAnimating()
        }
    }
}
