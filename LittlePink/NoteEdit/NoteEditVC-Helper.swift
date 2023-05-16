//
//  NoteEditVC-Helper.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/5/15.
//

import Foundation


extension NoteEditVC{
    
    func isValidateNote() -> Bool{
        
        guard !photos.isEmpty else {
            showTextHUD("至少需要传一张图片哦")
            return false
        }
        
        guard textViewIAView.currentTextCount <= kMaxNoteTextCount else {
            showTextHUD("正文最多输入\(kMaxNoteTextCount)字哦")
            return false
        }
        return true
    }
    
    func handleTFEditChanged(){
        //当前有高亮文本时(拼音键盘)return
        guard titleTextField.markedTextRange == nil else { return }
        
//        //用户输入完字符后进行判断,若大于最大字符数,则截取前面的文本(if里面第一行)
//        if titleTextField.unwrappedText.count > kMaxNoteTitleCount{
//            
//            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
//            
//            showTextHUD("标题最多输入\(kMaxNoteTitleCount)字哦")
//            
//            //用户粘贴文本后的光标位置,默认会跑到粘贴文本的前面,此处改成末尾
//            DispatchQueue.main.async {
//                let end = self.titleTextField.endOfDocument
//                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
//            }
//        }
//        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
}
