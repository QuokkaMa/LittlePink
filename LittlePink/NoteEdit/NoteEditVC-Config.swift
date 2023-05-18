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
        titleCountLable.text = "\(kMaxNoteTitleCount)"
        
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
        // 软键盘上面的view
        textView.inputAccessoryView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
        textViewIAView.doneBtn.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        textViewIAView.maxTextCountLabel.text = "/\(kMaxNoteTextCount)"

        //请求定位权限
        locationManager.requestWhenInUseAuthorization()
        
        AMapLocationManager.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        AMapLocationManager.updatePrivacyAgree(.didAgree)
        
        AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        AMapSearchAPI.updatePrivacyAgree(.didAgree)
        
    }
    
}

// MARK: - UITextViewDelegate
extension NoteEditVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        // 如果是高亮文字不展示
        guard textView.markedTextRange == nil else { return }
        // 更新文字
        textViewIAView.currentTextCount = textView.text.count
    }
}


// MARK: - 监听
extension NoteEditVC{
    @objc private func resignTextView(){
        textView.resignFirstResponder()
    }
}
