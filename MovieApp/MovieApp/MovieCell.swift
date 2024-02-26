//
//  MovieCell.swift
//  MovieApp
//
//  Created by 정성희 on 2024/02/23.
//

import Foundation
import UIKit
class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
    }
    
    @IBOutlet weak var priceLabel: UILabel!{
        didSet {
            priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
    }
    @IBOutlet weak var movieImage: UIImageView!
    
}
