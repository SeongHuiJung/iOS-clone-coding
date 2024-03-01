//
//  TodoListCell.swift
//  TodoList
//
//  Created by 정성희 on 2024/02/27.
//

import UIKit


class TodoListCell: UITableViewCell {
    
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var topTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
