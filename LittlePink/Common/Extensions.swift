//
//  Extensions.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/29.
//

import UIKit

extension UITextField{
    var unwrappedText: String { text ?? "" }
}

extension UIView{
    
    // 在 storyboard 右侧添加 圆角 设置
    @IBInspectable
    var radius: CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}

extension UIViewController{
    // MARK: - 展示加载框和提示框
    
    // MARK: 加载框 -- 手动隐藏
    
    // MARK: 提示框 -- 自动隐藏
    func showTextHUD(_ title: String, _ subTitle: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text  // 不指定的话显示菊花和下面配置的文本
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true,afterDelay: 2)
    }
    
    // MARK: - 添加手势 点击空白处 收回键盘
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // 不取消 其他触摸点击
        tap.cancelsTouchesInView  = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
}

extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
 
