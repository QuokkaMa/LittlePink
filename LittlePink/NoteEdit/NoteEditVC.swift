//
//  NoteEditVC.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/31.
//

import UIKit


class NoteEditVC: UIViewController {

    var photos = [
        UIImage(named: "1")!,UIImage(named: "2")!
    ]
    var videoUrl:URL?
//    var videoUrl:URL = Bundle.main.url(forResource: "testVideo", withExtension: "mp4")!
    
    @IBOutlet weak var photoCollectionview: UICollectionView!
    var isVideo: Bool{ videoUrl != nil}
    
    var photoCount: Int{ photos.count }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
