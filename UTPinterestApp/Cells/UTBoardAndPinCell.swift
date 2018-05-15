//
//  BoardAndPinCell.swift
//  
//
//  Created by Preferiti_mac on 18.04.18.
//

import UIKit

class UTBoardAndPinCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var pinLabel: UILabel!
    @IBOutlet weak var pinImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
