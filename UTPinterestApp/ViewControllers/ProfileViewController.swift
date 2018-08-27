//
//  ViewControllerPersonalData.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK

let profileIdentifier = "ViewControllerPersonalData"
let boardsIdentifier = "ViewControllerBoards"

class ProfileViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var boardsButton: UIButton!
    @IBOutlet weak var helloLabel: UILabel!
    
    //MARK: Properties
    var name: String?
    
    static func create(with name: String) -> ProfileViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: profileIdentifier) as! ProfileViewController
        controller.name = name
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Greeting"
        greetingLabel.text = name
    }
    
    //MARK: Method
    
    @IBAction func boardsButtonClicked(_ sender: UIButton) {
        let viewControllerBoards = mainStoryboard.instantiateViewController(withIdentifier: boardsIdentifier) as! PinsViewController
        self.navigationController?.pushViewController(viewControllerBoards, animated: true)
    }
}
