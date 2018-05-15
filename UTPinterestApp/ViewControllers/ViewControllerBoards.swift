//
//  ViewController.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 12.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK

class ViewControllerBoards: UIViewController, UITableViewDataSource {
    
    //MARK: Properties
    
    var pins: [PDKPin] = []
    var pinsWithDetails: [(url: String, width: Int, height: Int, color: UIColor)] = []
    var responseObject = PDKResponseObject()
    var user = PDKUser()
    var accessToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UITableViewDataSource methods
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UTBoardAndPinCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "UTBoardAndPinCell", for: indexPath) as! UTBoardAndPinCell
        return cell
    }
    
    //MARK: Methods
    
}
