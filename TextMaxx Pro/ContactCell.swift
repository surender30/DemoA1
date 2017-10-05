//
//  ContactCell.swift
//  TextMaxx Pro
//
//  Created by surender on 05/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    
    @IBOutlet var lbl_Name: UILabel!
     @IBOutlet var btn_Info: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
