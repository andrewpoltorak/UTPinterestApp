//
//  ViewControllerAuthorization.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK

class AuthorizationViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startLabel: UILabel!
    
    //MARK: Properties
    let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
        activityIndicator.stopAnimating()
    }
    
    //MARK: Metods
    
    func authenticateUser() {
        var stringWithName: String!
        let service = UTNetworkService()
        service.userData(authorizationViewController: self, completion: { withGreeting in
            stringWithName = withGreeting
        })
        var viewControllerPersonalData = ProfileViewController()
        viewControllerPersonalData = self.story.instantiateViewController(withIdentifier: "ViewControllerPersonalData") as! ProfileViewController
        self.navigationController!.pushViewController(viewControllerPersonalData, animated: true)
        _ = viewControllerPersonalData.view
        viewControllerPersonalData.greetingLabel.text = stringWithName ?? "Failed"
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        self.authenticateUser()
    }
}

