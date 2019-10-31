//
//  TopTopicCell.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 30/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopTopicCell: UITableViewCell {
    
    @IBOutlet weak var iconUser: UIImageView!
    @IBOutlet weak var titleTopic: UILabel!
    @IBOutlet weak var numberComments: UILabel!
    @IBOutlet weak var numberVisites: UILabel!
    @IBOutlet weak var dateTopic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configure(titleTopic: String, numberComments: String, numberVisites: String, dateTopic: String) {
        self.titleTopic.text = titleTopic
        self.numberComments.text = numberComments
        self.numberVisites.text = numberVisites
        self.dateTopic.text = dateTopic
    }
    
    static func estimateRowHeight() -> CGFloat {
        
        return 100.0
        
    }
    
    
}
