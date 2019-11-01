//
//  CustomView.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 01/11/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIImageView {

    @IBInspectable var alertView: Bool = false {
        
        didSet {
            
            if alertView {
                layer.isHidden = true
            } else {
                layer.isHidden = false
            }
            
        }
        
    }

}
