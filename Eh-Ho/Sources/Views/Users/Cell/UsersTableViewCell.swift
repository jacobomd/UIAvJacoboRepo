//
//  UsersTableViewCell.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var messageButton: CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageButton.alertButton = false
        
    }

    func configure(userName: String, name: String) {
        labelUserName.text = userName
        labelName.text = name
    }

}
