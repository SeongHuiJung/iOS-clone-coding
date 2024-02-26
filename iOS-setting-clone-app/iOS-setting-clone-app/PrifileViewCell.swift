//
//  PrifileViewCell.swift
//  iOS-setting-clone-app
//
//  Created by 정성희 on 2024/02/13.
//

import UIKit

class PrifileViewCell: UITableViewCell {
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var bottomDescription: UILabel!
    
    //nib 파일과 연결되고 메모리에 올라가는 시점
    override func awakeFromNib() {
        super.awakeFromNib()
        let profileHeight:CGFloat = 60
        profileImageView.layer.cornerRadius = profileHeight/2
        
        topTitle.textColor = .red
        topTitle.font = UIFont.systemFont(ofSize: 20)
        
        bottomDescription.textColor = .red
        bottomDescription.font = UIFont.systemFont(ofSize: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
