//
//  DetailViewController.swift
//  MovieApp
//
//  Created by 정성희 on 2024/02/24.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    var movieResult :MovieResult? {
        didSet{
            //아래 코드를 여기서 실행하게 되면
            //view did load -> 디테일 뷰 켜짐 -> 임시 데이터 보여짐 -> 해당 데이터로 변경됨
            //순서여서 사용자가 임시 데이터를 보게됨. 따라서 viewdidLoad 에서 실행해 주는 것이좋음
            /*
            titleLabel.text = movieResult?.trackName
            descriptionLabel.text = movieResult?.longDescription
             */
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        }
    }
    @IBOutlet weak var movieContainer: UIView!
    
    //viewdidload 는 화면에 보여지기 직전 메모리 셋팅이 모두 완료된 상태
    //화면이 보여지기 직전 설정해야 하는 세팅들을 여기서 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
        
        
        
    }
    
    func makePlayerAndPlay(urlString: String) {
        if let hasUrl = URL(string: urlString) {
            var player = AVPlayer(url: hasUrl)
            let playerLayer = AVPlayerLayer(player: player)
            
            //layer 는 movieContainer 에 그냥 addSublayer하면 안됨. layer.addSublayer로 해주어야함
            movieContainer.layer.addSublayer(playerLayer)
            
            //레이어 프레임 크기 지정.
            //레이어는 autolayer 를 설정할 수 없고 오직 x,y 값 등 절대값만 사용할 수 있음
            //view did load 에서 makePlayerAndPlay함수를 실행하면 movieContainer.bounds 는 현재 작업중인 화면의 크기로 잡아오고, 실제 작동되는 디바이스의 크기를 가져오는 것이 아님. 그래서 view did load 에서 이 함수를 실행하면 안됨
            //viewdidappear 에서 실행하면 실제 디바이스의 크기, 위치값을 가져오게됨
            playerLayer.frame = movieContainer.bounds
            
            player.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let hasURL = movieResult?.previewUrl {
            makePlayerAndPlay(urlString: hasURL)
        }
    }
}
