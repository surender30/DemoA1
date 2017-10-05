//
//  profileCell1.swift
//  TextMaxx Pro
//
//  Created by Surender on 10/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit

class profileCell1: UITableViewCell {

    
    @IBOutlet weak var img_profile: UIImageView!
    
    @IBOutlet var txtField_Name: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
