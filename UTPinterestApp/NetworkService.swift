//
//  NetworkService.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 24.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import PinterestSDK

//MARK: Properties

var viewControllerAuthorization = ViewControllerAuthorization()

//MARK: Metods

func authenticateUser() {
    PDKClient.sharedInstance().authenticate(withPermissions: [PDKClientReadPublicPermissions,PDKClientWritePublicPermissions,PDKClientReadRelationshipsPermissions,PDKClientWriteRelationshipsPermissions], from: viewControllerAuthorization, withSuccess: { (PDKResponseObject) in
        viewControllerAuthorization.activityIndicator.stopAnimating()
        viewControllerAuthorization.accessToken = PDKClient.sharedInstance().oauthToken
        userData()
    }, andFailure: {
        (Error) in
        viewControllerAuthorization.view.isUserInteractionEnabled = true
        viewControllerAuthorization.startLabel.text = "Please try again..."
        viewControllerAuthorization.activityIndicator.stopAnimating()
    })
}

func userData() {
    let parameters: [String : String] = ["fields": "first_name,id,last_name,url,image,username,bio,counts,created_at,account_type"]
    PDKClient.sharedInstance().getPath("/v1/me/", parameters: parameters, withSuccess: {
        (PDKResponseObject) in
        var viewControllerPersonalData = ViewControllerPersonalData()
        viewControllerPersonalData = viewControllerAuthorization.story.instantiateViewController(withIdentifier: "ViewControllerPersonalData") as! ViewControllerPersonalData
        viewControllerAuthorization.navigationController!.pushViewController(viewControllerPersonalData, animated: true)
        viewControllerAuthorization.user = (PDKResponseObject?.user())!
        _ = viewControllerPersonalData.view
        viewControllerPersonalData.greetingLabel.text = "Welcome " + (PDKResponseObject?.user().firstName)! + " " + (PDKResponseObject?.user().lastName != nil ? (PDKResponseObject?.user().lastName)! : "")
    }) {
        (Error) in
        viewControllerAuthorization.view.isUserInteractionEnabled = true
        viewControllerAuthorization.startLabel.text = "Try again..."
        viewControllerAuthorization.activityIndicator.stopAnimating()
    }
}
