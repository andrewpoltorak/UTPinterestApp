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
        
    //MARK: Metods
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        service.userData(authorizationViewController: self, completion: {
            self.activityIndicator.stopAnimating()
            let viewControllerPersonalData = ProfileViewController.create(with: $0)
            self.navigationController?.pushViewController(viewControllerPersonalData, animated: true)
        })
    }
}

