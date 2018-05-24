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
    let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
    }
    
    //MARK: Metods
    
    func authenticateUser() {
        let service = UTNetworkService()
        service.authenticateUser(from: self)
        var viewControllerPersonalData = ViewControllerPersonalData()
        viewControllerPersonalData = self.story.instantiateViewController(withIdentifier: "ViewControllerPersonalData") as! ViewControllerPersonalData
        self.navigationController!.pushViewController(viewControllerPersonalData, animated: true)
        _ = viewControllerPersonalData.view
        viewControllerPersonalData.greetingLabel.text = service.greetingWithName
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        self.authenticateUser()
    }
}

