//
//  NoteEdit-CollectionView.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/4.
//

import YPImagePicker
import SKPhotoBrowser
import AVKit

extension NoteEditVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        
        cell.imageView.image = photos[indexPath.item]
        // 设置图片圆角
        // cell.contentView.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            photoFooter.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            return photoFooter
        default :
            fatalError("UICollectionViewDataSource 的 footer 出现异常! ")
        }
    }
    
}

// MARK: - UICollectionViewDelegate
extension NoteEditVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isVideo {
            // 点击编辑界面的视频,进行预览
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoUrl!)
            present(playerVC, animated: true){
                playerVC.player?.play()
            }
        } else {
            // 点击编辑界面的图片,进行放大
            // 1. create SKPhoto Array from UIImage
            var images = [SKPhoto]()
            for photo in photos {
                images.append(SKPhoto.photoWithImage(photo))
            }
            
            // 2. create PhotoBrowser Instance, and present from your viewController.
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            present(browser, animated: true)
        }
    }
}

// MARK: - SKPhotoBrowserDelegate
extension NoteEditVC: SKPhotoBrowserDelegate{
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        // 点击编辑界面图片内容刷新
        photoCollectionview.reloadData()
        // SKPhotoBrowserDelegate 内容刷新
        reload()
    }
    
}


// MARK: - 监听
extension NoteEditVC{
    @objc private func addPhoto(){
        if photoCount < kMaxPhotoCount{
            var config = YPImagePickerConfiguration()
            
            // MARK: 通用配置
            config.albumName = Bundle.main.appName //存图片进相册App的'我的相簿'里的文件夹名称
            config.startOnScreen = .library //一打开就展示相册
            config.screens = [.library] //依次展示相册，拍视频，拍照页面
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true //是否可多选
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount //最大选取照片或视频数
            config.library.spacingBetweenItems = kSpacingBetweenItems //照片缩略图之间的间距

            // MARK: - Gallery(多选完后的展示和编辑页面)-画廊
            config.gallery.hidesRemoveButton = false //每个照片或视频右上方是否有删除按钮
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, _ in

                for item in  items {
                    if case let .photo(photo) = item{
                        self.photos.append(photo.image)
                    }
                }
                self.photoCollectionview.reloadData()
                
                picker.dismiss(animated: true)
            }
            
            present(picker, animated: true)
        }else{
            showTextHUD("最多只能选择\(kMaxPhotoCount)张照片哦")
        }
    }
    
}
