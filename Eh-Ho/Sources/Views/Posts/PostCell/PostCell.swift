//
//  PostCell.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 27/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var numberVisit: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configure(avatarImage: UIImage, userName: String, descripcion: String, numberVisit: String, date: String) {
        
        self.avatarImage.image = avatarImage
        self.userName.text = userName
        self.numberVisit.text = numberVisit
        self.date.text = date
        self.descripcion.text = descripcion
        
    }
    
    static func estimateRowHeight() -> CGFloat {
        
        return 100.0
        
    }
    
}
