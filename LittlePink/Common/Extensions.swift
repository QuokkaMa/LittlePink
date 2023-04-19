//
//  Extensions.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/29.
//

import UIKit

 
extension String{
    var isBlank: Bool{ self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
//    var isPhoneNum: Bool{ Int(self) != nil && NSRegularExpression(kPhoneRegEx).matches(self) }
//
//    var isAuthCode: Bool{ Int(self) != nil && NSRegularExpression(kAuthCodeRegEx).matches(self) }
//
//    var isPassword: Bool{ NSRegularExpression(kPasswordRegEx).matches(self) }
//
//    static func randomString(_ length: Int) -> String{
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//        return String((0..<length).map{ _ in letters.randomElement()! })
//    }
//
//    //拼接富文本
//    func spliceAttrStr(_ dateStr: String) -> NSMutableAttributedString{
//        let attrText = toAttrStr()
//        let attrDate = " \(dateStr)".toAttrStr(12, .secondaryLabel)
//
//        attrText.append(attrDate)
//
//        return attrText
//    }
//    //普通字符串转化为富文本
//    func toAttrStr(_ fontSize: CGFloat = 14, _ color: UIColor = .label) -> NSMutableAttributedString{
//        let attr: [NSAttributedString.Key: Any] = [
//            .font: UIFont.systemFont(ofSize: fontSize),
//            .foregroundColor: color
//        ]
//        return NSMutableAttributedString(string: self, attributes: attr)
//    }
    
}

extension Optional where Wrapped == String{
    var unwrappedText: String { self ?? "" }
}

extension UITextField{
    var unwrappedText: String { text ?? "" }
    
    var exactText: String {
        unwrappedText.isBlank ? "" : unwrappedText
    }
}

extension UITextView{
    var unwrappedText: String { text ?? "" }
    var exactText: String {
        unwrappedText.isBlank ? "" : unwrappedText
    }
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
    func showLoadHUD(_ title: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
    }
    func hideLoadHUD(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    static func showGlobalLoadHUD(_ title: String? = nil){
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.windows.last!, animated: true)
        hud.label.text = title
    }
    static func hideGlobalHUD(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: UIApplication.shared.windows.last!, animated: true)
        }
    }
    
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
    
    // MARK: 静态属性和方法--1.直接用类名进行调用,2.省资源
    // MARK: static和class的区别
    //static能修饰class/struct/enum的存储属性、计算属性、方法;class能修饰类的计算属性和方法
    //static修饰的类方法不能继承；class修饰的类方法可以继承
    //在protocol中要使用static
    
    //加载xib上的view
    //为了更通用，使用泛型。as?后需接类型，故形式参数需为T.Type，实质参数为XXView.self--固定用法
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T{
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T{
            return view
        }
        fatalError("加载\(type)类型的view失败")
    }
}
 
