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
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var titleCountLable: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var photoCollectionview: UICollectionView!
    
    var isVideo: Bool{ videoUrl != nil}
    
    var photoCount: Int{ photos.count }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 开启拖放交互
        photoCollectionview.dragInteractionEnabled = true
        // 点击空白处 收回键盘
        hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLable.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLable.isHidden = true
    }
    
    
    @IBAction func TFDidOnExit(_ sender: Any) {
        // 点击键盘 "完成: 收起小键盘 空方法即可
    }
}


extension NoteEditVC: UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // 点击键盘 "完成: 收起小键盘
//        textField.resignFirstResponder()
//        return true
//    }
}
