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
    
    var photoCount: Int{ photos.count }
    var isVideo: Bool{ videoUrl != nil}
    var textViewIAView: TextViewIAView{ textView.inputAccessoryView as! TextViewIAView }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    
    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLable.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLable.isHidden = true
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        // 输入文字高亮时, 不减最大输入文字数
        guard titleTextField.markedTextRange == nil else {return}
        if titleTextField.unwrappedText.count > kMaxPhotoCount {
            // 截取字符串
            titleTextField.text = String(titleTextField.unwrappedText.prefix(KMaxNoteTitleCount))
            showTextHUD("标题最多输入\(KMaxNoteTitleCount)")
            // 移动光标位置
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
            
        titleCountLable.text = "\(KMaxNoteTitleCount - titleTextField.unwrappedText.count)"
        
    }
    
    @IBAction func TFDidOnExit(_ sender: Any) {
        // 点击键盘 "完成: 收起小键盘 空方法即可
    }
}


//extension NoteEditVC: UITextFieldDelegate{
//    // 点击键盘 "完成: 收起小键盘
//    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    //
//    //        textField.resignFirstResponder()
//    //        return true
//    //    }
//
//    // 标题超过 20 戈文字进行拦截
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        guard titleTextField.markedTextRange == nil else {return false}
//
//        let isExceed = range.location >= KMaxNoteTitleCount || (textField.unwrappedText.count + string.count ) > KMaxNoteTitleCount
//
//        if isExceed {
//            showTextHUD("标题最多输入\(KMaxNoteTitleCount)")
//        }
//
//        return !isExceed
//    }
//}
