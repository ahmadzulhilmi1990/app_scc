//
//  CustomLabel.swift
//  
//
//  Created by user on 14/09/2017.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }

}
