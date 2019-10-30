//
//  UserCell.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 28/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellName.textColor = .white
    }
    
    
    
    func configure(cellImage: UIImage, cellName: String) {
        self.cellImage.image? = cellImage
        self.cellName.text! = cellName
    }

}
