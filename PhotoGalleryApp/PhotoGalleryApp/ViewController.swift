//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 정성희 on 2024/02/22.
//

import UIKit
import PhotosUI // photo 와 관련된 모듈 import

class ViewController: UIViewController {
    
    var fetchResults: PHFetchResult<PHAsset>?
    
    var images = [UIImage?]()

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Gallery App"
        
        makeNavigationItem()
        
        photoCollectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        // 아이템 하나당 사이즈 설정
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 0.5 , height: 200)
        
        // 아이템 끼리의 "가로" 사이 간격
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        // photoCollectionView에 layout 적용
        photoCollectionView.collectionViewLayout = layout
    }
    
    func makeNavigationItem() {
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle") , style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.leftBarButtonItem = refreshItem
    }
    
    @objc func checkPermission () {
        // 권한 허용된 경우
        if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited {
            
                self.showGallery()
            
        }
        // 권한 거부된 경우
        else if PHPhotoLibrary.authorizationStatus() == .denied{
            
                self.showAuthorizationDeniedAlert()
            
        }
        // 권한 설정을 아직 물어보지 않은 경우
        else if PHPhotoLibrary.authorizationStatus() == .notDetermined{
            // 권한 설정 띄우기
            
            PHPhotoLibrary.requestAuthorization { status in
                //권한 설정 이후에 아무것도 되지 않기 때문에 다시 해당 함수를 불러옴
                //아래 코드는 클로저 안에서 실행 된 것이기 때문에 메인 스레드가 아닌 다른 스레드에서 실행이 되었음.
                //그럼 권한 허용된 경우나 권한 거부된 경우 같은 경우는 ui를 바꾸는 것이기 때문에 꼭 필수로 메인 스레드에서 실행하게 해줘야함
                //!!ui 관련은 메인스레드에서만 할 수 있음!!- 왜? 더 공부해보기
                self.checkPermission()
            }
        }
    }
    
    func showAuthorizationDeniedAlert() {
        let alert = UIAlertController(title: "알림", message: "포토라이브 접근 권한을 허용해 주세요", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default, handler: { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:])
            }
        }))
        self.present(alert, animated: true)
    }
    
    func showGallery() {
        let library = PHPhotoLibrary.shared() //shared 싱글톤
        
        var configuration = PHPickerConfiguration(photoLibrary: library)
        
        //한번에 선택할 수 있는 사진 최대 수
        configuration.selectionLimit = 10
        
        //initialize
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func refresh() {
        self.photoCollectionView.reloadData()
    }
   
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)as! PhotoCell
        
        if let asset = self.fetchResults?[indexPath.row] {
            cell.loadImage(asset: asset)
        }
        
        return cell
    }
}


extension ViewController : PHPickerViewControllerDelegate {
    //사진 선택하고 확인 또는 취소 눌렀을 때 실행
    //취소 누르면 results 값이 nil, 사진 선택 후 확인 누르면 results 값이 있음
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        //배열 내부의 optional 벗겨내는 법
        let identifies = results.map{
            $0.assetIdentifier ?? ""
        }
    
        //아이디로 어셋을 가져옴
        fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifies, options: nil)
        
        self.photoCollectionView.reloadData()
        
        //자동으로 닫아주지 않아서 버튼 클릭시 직접 닫아주는 코드 추가
        dismiss(animated: true)
    }
    
    
}
