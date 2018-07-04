//
//  RowFilter.swift
//  SupplyChainCity
//
//  Created by user on 05/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation
import UIKit

class RowFilter: UITableViewCell {
    
    @IBOutlet weak var txt_title: UILabel!
    @IBOutlet weak var img_tick: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
