//
//  FinsUserCell.swift
//  TextMaxx Pro
//
//  Created by surender on 14/11/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit

class FinsUserCell: UITableViewCell {

    
    @IBOutlet weak var lbl_Name: UILabel!
    
    @IBOutlet weak var btn_AddUser: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
