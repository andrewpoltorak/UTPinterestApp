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
    var viewControllerBoards = ViewControllerBoards()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Greeting"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Metods
    
    @IBAction func boardsButtonClicked(_ sender: UIButton) {
        self.viewControllerBoards = self.story.instantiateViewController(withIdentifier: "ViewControllerBoards") as! ViewControllerBoards
        self.navigationController!.pushViewController(self.viewControllerBoards, animated: true)
        _ = self.viewControllerBoards.view
       // self.getPins()
    }
    
//    func getPins() {
//        PDKClient.sharedInstance().getPath("/v1/me/pins/", parameters: [:], withSuccess: {
//            (PDKResponseObject) in
//            self.view.isUserInteractionEnabled = true
//            self.viewControllerBoards.pins = PDKResponseObject?.pins() as! [PDKPin]
//        }) {
//            (Error) in
//            print("Error")
//        }
//    }
}
