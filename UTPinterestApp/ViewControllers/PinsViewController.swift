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

class PinsViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Properties
    var pins: [PDKPin] = []
    var pinsWithDetails: [PinDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
        service.getPins(completion: {
            $0.forEach { self.loadPinDetails(with: $0.identifier) }
        })
    }
    
    //MARK: Methods
    
    private func loadPinDetails(with identifier: String) {
        service.loadPinDetails(identifier, completion: {
            self.pinsWithDetails.append($0)
            self.collectionView.reloadData()
        })
    }
}

//MARK: Flow layout delegate

extension PinsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColums: CGFloat = 2
        let widht = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 5
        let calculatedWidth = (widht / numberOfColums) - (xInsets + cellSpacing)
        let calculatedHeight = (widht / numberOfColums) - (xInsets + cellSpacing)
        return CGSize(width: calculatedWidth, height: calculatedHeight)
    }
}

//MARK: Data source

extension PinsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.pins.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell",
                                                      for: indexPath) as! PhotoCell
        let pinDetails = pinsWithDetails[indexPath.row]
        if let urlString = pinDetails.url,
            let url = URL(string: urlString) {
            cell.imageView.sd_setImage(with: url)
        }
        return cell
    }
}
