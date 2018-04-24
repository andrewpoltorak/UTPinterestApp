//
//  ViewControllerAuthorization.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK
//import NetworkService

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
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        //var service = NetworkService()
    }
}
