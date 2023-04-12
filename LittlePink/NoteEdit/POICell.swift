//
//  POICell.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/11.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    var poi = ["", ""]{
        didSet{
            nameLabel.text = poi[0]
            addressLabel.text = poi[1]
        }
    }
    
}
