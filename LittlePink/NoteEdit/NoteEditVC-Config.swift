//
//  NoteEditVC-Config.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/6.
//

import Foundation

extension NoteEditVC{
    
    func config(){
        // 开启拖放交互
        photoCollectionview.dragInteractionEnabled = true
        // 点击空白处 收回键盘
        hideKeyboardWhenTappedAround()
        // 初始化标题最大数字
        titleCountLable.text = "\(KMaxNoteTitleCount)"
        
        // 设置文本框内边距
        let lineFragmentPadding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0,left: -lineFragmentPadding, bottom: 0,right: -lineFragmentPadding)
        
        // 行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let typingAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.secondaryLabel
        ]
        textView.typingAttributes = typingAttributes
        // 光标颜色
        textView.tintColorDidChange()
    }
    
}
