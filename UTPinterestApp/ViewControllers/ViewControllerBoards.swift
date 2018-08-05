//
//  ViewController.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 12.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import PinterestSDK
import SDWebImage
import SwiftyJSON

class ViewControllerBoards: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Properties
    var pins: [PDKPin] = []
    var pinsWithDetails: [(url: String, width: Int, height: Int, color: UIColor)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
        self.getPins()
        self.fetchPinsDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
    }
    
    //MARK: Methods
    
    func getPins() {
        let pinService = UTNetworkService()
        pinService.getPins(completion: { pins in
            self.pins = pins
        })
    }
    
    func fetchPinsDetails() {
        var count = 0
        for i in 0..<pins.count {
            self.pinsWithDetails.append(("",1,1,hexStringToUIColor(hex: "EEEEEE")))
            let fields: Set = ["image","color"]
            PDKClient.sharedInstance().getPinWithIdentifier(pins[i].identifier, fields: fields, withSuccess: { (PDKResponseObject) in
                count += 1
                
                let pin = JSON(PDKResponseObject?.pin().images["original"] as Any)
                
                if let color = JSON(PDKResponseObject?.parsedJSONDictionary as Any)["color"].string {
                    self.pinsWithDetails[i].color = self.hexStringToUIColor(hex: color)
                }
                
                if let url = pin["url"].string {
                    self.pinsWithDetails[i].url = url
                }
                
                if let width = pin["width"].int {
                    self.pinsWithDetails[i].width = width
                }
                
                if let height = pin["height"].int {
                    self.pinsWithDetails[i].height = height
                }
                
                if (count == self.pinsWithDetails.count) {
                    self.collectionView.reloadData()
                }
                
            }) { (Error) in
                
                print("Error in fetching pin " + String(i) + "\n")
            }
        }
    }
}

//MARK: Flow layout delegate

extension ViewControllerBoards: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColums: CGFloat = 2
        let widht = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 5
        return CGSize(width: ((widht / numberOfColums) - (xInsets + cellSpacing)), height: ((widht / numberOfColums) - (xInsets + cellSpacing)))
    }
}

//MARK: Data source

extension ViewControllerBoards: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.imageView.sd_setImage(with: URL(string: pinsWithDetails[indexPath.row].url))
        return cell
    }
}

extension ViewControllerBoards {
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
}
