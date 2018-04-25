//
//  ViewControllerAuthorization.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK

class ViewControllerAuthorization: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startLabel: UILabel!
    
    //MARK: Properties
    var user = PDKUser()
    var accessToken = ""
    let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicator.stopAnimating()
        self.reloadInputViews()
    }
    
    //MARK: Metods
    
    func authenticateUser() {
        PDKClient.sharedInstance().authenticate(withPermissions: [PDKClientReadPublicPermissions,PDKClientWritePublicPermissions,PDKClientReadRelationshipsPermissions,PDKClientWriteRelationshipsPermissions], from: self, withSuccess: { (PDKResponseObject) in
            self.activityIndicator.stopAnimating()
            self.accessToken = PDKClient.sharedInstance().oauthToken
            self.userData()
        }, andFailure: {
            (Error) in
            self.view.isUserInteractionEnabled = true
            self.startLabel.text = "Please try again..."
            self.activityIndicator.stopAnimating()
        })
    }
    
    func userData() {
        let parameters: [String : String] = ["fields": "first_name,id,last_name,url,image,username,bio,counts,created_at,account_type"]
        PDKClient.sharedInstance().getPath("/v1/me/", parameters: parameters, withSuccess: {
            (PDKResponseObject) in
            var viewControllerPersonalData = ViewControllerPersonalData()
            viewControllerPersonalData = self.story.instantiateViewController(withIdentifier: "ViewControllerPersonalData") as! ViewControllerPersonalData
            self.navigationController!.pushViewController(viewControllerPersonalData, animated: true)
            self.user = (PDKResponseObject?.user())!
            _ = viewControllerPersonalData.view
            viewControllerPersonalData.greetingLabel.text = "Welcome " + (PDKResponseObject?.user().firstName)! + " " + (PDKResponseObject?.user().lastName != nil ? (PDKResponseObject?.user().lastName)! : "")
        }) {
            (Error) in
            self.view.isUserInteractionEnabled = true
            self.startLabel.text = "Try again..."
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        self.authenticateUser()
    }
}

