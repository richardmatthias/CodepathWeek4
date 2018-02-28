//
//  SomeCell.swift
//  Insta
//
//  Created by Langtian Qin on 2/27/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class SomeCell: UITableViewCell {


    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var weView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
