//
//  OnBoardingItemViewController.swift
//  OnBoardingViewApp
//
//  Created by 정성희 on 2024/02/19.
//
//ui에 들어가는 변수들의 연결, 설정값들은 여기서
import UIKit

class OnBoardingItemViewController: UIViewController {

    var mainText = ""
    var subText = ""
    //image 는 값이 없을 수도 있어서 optional 로 많이 하는 편
    var topImage : UIImage? = UIImage()
    
    @IBOutlet private weak var topImageView: UIImageView!
    
    @IBOutlet private weak var mainTitleLabel: UILabel! {
        didSet {
            mainTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTitleLabel.text = mainText
        topImageView.image = topImage
        descriptionLabel.text = subText
    }
}
