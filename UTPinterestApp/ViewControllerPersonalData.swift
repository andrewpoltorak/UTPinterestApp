//
//  ViewControllerPersonalData.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK

class ViewControllerPersonalData: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var boardsButton: UIButton!
    
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Metods
//    func greetingUser() {
//        PDKClient.sharedInstance().authenticate(withPermissions: [PDKClientReadPublicPermissions,PDKClientWritePublicPermissions,PDKClientReadRelationshipsPermissions,PDKClientWriteRelationshipsPermissions], from: self, withSuccess: { (PDKResponseObject) in
//            self.accessToken = PDKClient.sharedInstance().oauthToken
//            let parameters: [String : String] = ["fields": "first_name,id,last_name,url,image,username,bio,counts,created_at,account_type"]
//            PDKClient.sharedInstance().getPath("/v1/me/", parameters: parameters, withSuccess: {
//                (PDKResponseObject) in
//                self.user = (PDKResponseObject?.user())!
//                self.greetingLabel.text = "Welcome " + (PDKResponseObject?.user().firstName)! + " " + (PDKResponseObject?.user().lastName != nil ? (PDKResponseObject?.user().lastName)! : "")
//            }) {
//                (Error) in
//                self.view.isUserInteractionEnabled = true
//                self.greetingLabel.text = "Try again..."
//            }
//        }, andFailure: {
//            (Error) in
//            self.view.isUserInteractionEnabled = true
//            self.greetingLabel.text = "Please try again..."
//        })
//    }
}
