//
//  MenuCell.swift
//  iOS-setting-clone-app
//
//  Created by 정성희 on 2024/02/13.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var middleTitle: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
