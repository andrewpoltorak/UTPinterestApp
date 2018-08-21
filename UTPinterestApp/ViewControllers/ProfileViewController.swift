//
//  ViewControllerPersonalData.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 14.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK

class ProfileViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var boardsButton: UIButton!
    @IBOutlet weak var helloLabel: UILabel!
    
    //MARK: Properties
    let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Greeting"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Method
    
    @IBAction func boardsButtonClicked(_ sender: UIButton) {
        var viewControllerBoards = PinsViewController()
        viewControllerBoards = self.story.instantiateViewController(withIdentifier: "ViewControllerBoards") as! PinsViewController
        self.navigationController!.pushViewController(viewControllerBoards, animated: true)
        _ = viewControllerBoards.view
    }
}
