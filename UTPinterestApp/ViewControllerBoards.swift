//
//  ViewController.swift
//  UTPinterestApp
//
//  Created by Preferiti_mac on 12.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewControllerBoards: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let images = [#imageLiteral(resourceName: "Image-1"), #imageLiteral(resourceName: "Image-2"), #imageLiteral(resourceName: "Image-3"), #imageLiteral(resourceName: "Image-4"), #imageLiteral(resourceName: "Image-5"), #imageLiteral(resourceName: "Image-6"), #imageLiteral(resourceName: "Image-7")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: Flow layout delegate

extension ViewControllerBoards: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let inset: CGFloat = 10
        let cellSpacing: CGFloat = 5
        return CGSize(width: (width / numberOfColumns) - (inset + cellSpacing), height: (width / numberOfColumns) - (inset + cellSpacing))
    }
}

// MARK: Data Source

extension ViewControllerBoards: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let image = images[indexPath.row]
        cell.imageView.image = image
        return cell
    }
}
