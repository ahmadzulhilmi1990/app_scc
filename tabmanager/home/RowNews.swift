//
//  RowNews.swift
//  SupplyChainCity
//
//  Created by user on 18/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation
import UIKit

class RowNews: UITableViewCell {
    
    @IBOutlet weak var txt_title: UILabel!
    @IBOutlet weak var txt_desc: UILabel!
    @IBOutlet weak var img_view: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
