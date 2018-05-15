//
//  ModalWindow.swift
//  
//
//  Created by Robert Chen on 8/5/18.
//  Copyright (c) 2018 Nemi. All rights reserved.
//

import UIKit

class ModalWindow : UIViewController {
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
