//
//  TableViewCell.swift
//  My Uber App ForRider
//
//  Created by julia on 30.08.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bestDriverLabel: UILabel!
    
    @IBOutlet weak var raitingDriverLabel: UILabel!
    
    @IBOutlet weak var imageForDriverPic: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
