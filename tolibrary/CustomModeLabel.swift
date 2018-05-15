//
//  CustomModeLabel.swift
//  
//
//  Created by user on 14/09/2017.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import UIKit

class CustomModeLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        //self.layer.backgroundColor = UIColor.white.cgColor
        //self.layer.backgroundColor = UIColor.white as! CGColor
        self.layer.borderColor = UIColor.gray.cgColor
    }
}
