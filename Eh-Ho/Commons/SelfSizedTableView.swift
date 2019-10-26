//
//  SelfSizedTableView.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 26/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//


import UIKit

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
