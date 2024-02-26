//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by 정성희 on 2024/02/22.
//

import UIKit
import PhotosUI
class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!{
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func loadImage(asset: PHAsset) {
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: scale * 150, height: scale * 150)
        
        //이미지 받을때 저화질로 한번, 고화질로 한번 총 두번을 받게 됨. 그래서 options 에서 한번 받을지 두번 받을지 결정할 수 있게 됨.
        //기본 값은 저화질 고화질 한번씩 총 두 번을 받게 된다
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: nil) { image, info in
            self.photoImageView.image = image
        }
    }
}
