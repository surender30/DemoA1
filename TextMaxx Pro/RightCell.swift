//
//  RightCell.swift
//  TextMaxx Pro
//
//  Created by Surender on 08/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit

class RightCell: UITableViewCell {

    
    @IBOutlet weak var lbl_outMessage: UILabel!
     @IBOutlet weak var lbl_outTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
