//
//  SettingCell.swift
//  TextMaxx Pro
//
//  Created by surender on 04/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    
    @IBOutlet var btn_Fb: UIButton!
    @IBOutlet var btn_Twitter: UIButton!
    @IBOutlet var btn_Instagram: UIButton!
    @IBOutlet var btn_Youtube: UIButton!
    
  

    @IBOutlet var lbl_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
