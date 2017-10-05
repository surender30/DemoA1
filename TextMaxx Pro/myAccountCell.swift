//
//  myAccountCell.swift
//  TextMaxx Pro
//
//  Created by Nitin Suri on 05/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit

class myAccountCell: UITableViewCell {
    
    @IBOutlet var lbl_Staic: UILabel!
    @IBOutlet var txtField_SetValue : UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
