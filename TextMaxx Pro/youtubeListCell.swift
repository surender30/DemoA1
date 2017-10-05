//
//  youtubeListCell.swift
//  TextMaxx Pro
//
//  Created by surender on 18/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit

class youtubeListCell: UITableViewCell {
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var img_thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
