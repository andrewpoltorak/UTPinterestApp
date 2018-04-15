//
//  ViewControllerAuthorization.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK
import SwiftyJSON

class ViewControllerAuthorization: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    var user = PDKUser()
    var accessToken = ""
    let story = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicator.stopAnimating()
    }
    
    //MARK: Metods
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonLoginClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        PDKClient.sharedInstance().authenticate(withPermissions: [PDKClient.sharedInstance().silentlyAuthenticateWithSuccess( { (responseObject :PDKResponseObject!) -> Void in
            
            self.activityIndicator.stopAnimating()
            self.accessToken = PDKClient.sharedInstance().oauthToken
            
            let parameters : [String:String] =
                [
                    "fields":  "first_name,last_name,url,image,username"
            ]
            
            PDKClient.sharedInstance().getPath("/v1/me/", parameters: parameters, withSuccess: {
                
                (PDKResponseObject) in
                let viewControllerPersonalData = story.instantiateViewController(withIdentifier: "viewControllerPersonalData") as ViewControllerPersonalData
                self.presentViewController(viewControllerPersonalData, animated: true)
            }) {
                (Error) in
                if let error = Error
                {
                    print("Error")
                }
                self.view.isUserInteractionEnabled = true
            }
        }
        }))
}


