//
//  ViewController.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 12.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK

class ViewControllerBoards: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
        self.getPins()
    }
    
    //MARK: Methods
    
    func getPins() {
        let pinService = UTNetworkService()
        pinService.getPins(completion: { pins in
            let pinsArray: [PDKPin] = pins
            print(pinsArray)
        })
    }
}
