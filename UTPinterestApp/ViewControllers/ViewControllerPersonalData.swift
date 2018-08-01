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
    
    //MARK: Metod
    
    @IBAction func boardsButtonClicked(_ sender: UIButton) {
        var viewControllerBoards = ViewControllerBoards()
        viewControllerBoards = self.story.instantiateViewController(withIdentifier: "ViewControllerBoards") as! ViewControllerBoards
        self.navigationController!.pushViewController(viewControllerBoards, animated: true)
        _ = viewControllerBoards.view
    }
}
