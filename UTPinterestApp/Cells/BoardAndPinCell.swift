//
//  BoardAndPinCell.swift
//  
//
//  Created by Preferiti_mac on 18.04.18.
//

import UIKit

class BoardAndPinCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var pinLabel: UILabel!
    @IBOutlet weak var pinImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
