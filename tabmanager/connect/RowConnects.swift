//
//  RowConnects.swift
//  SupplyChainCity
//
//  Created by user on 24/06/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation
import UIKit

class RowConnects: UITableViewCell {
    
    @IBOutlet weak var txt_title: UILabel!
    @IBOutlet weak var txt_position: UILabel!
    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var img_online: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

