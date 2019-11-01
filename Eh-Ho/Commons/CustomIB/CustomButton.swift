//
//  CustomButton.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 01/11/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable var alertButton: Bool = false {
        
        didSet {
            if alertButton {
                layer.isHidden = true
            } else {
                layer.isHidden = false
            }
        }
        
    }
    
    

}
