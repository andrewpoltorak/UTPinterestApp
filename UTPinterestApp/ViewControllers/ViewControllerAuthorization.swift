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
        self.activityIndicator.stopAnimating()
        let service = UTNetworkService()
        service.authenticateUser()
        self.userData()
    }
    
    func userData() {
            var viewControllerPersonalData = ViewControllerPersonalData()
            viewControllerPersonalData = self.story.instantiateViewController(withIdentifier: "ViewControllerPersonalData") as! ViewControllerPersonalData
            self.navigationController!.pushViewController(viewControllerPersonalData, animated: true)
            _ = viewControllerPersonalData.view
        let service = UTNetworkService()
        let greetingWithName = service.userData()
            viewControllerPersonalData.greetingLabel.text = greetingWithName
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        self.authenticateUser()
    }
}

