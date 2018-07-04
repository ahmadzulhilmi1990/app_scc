//
//  CustomAlertViewDelegate.swift
//  SupplyChainCity
//
//  Created by user on 24/06/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation

protocol CustomAlertViewDelegate: class {
    func okButtonTapped(selectedOption: String)
    func cancelButtonTapped()
}
