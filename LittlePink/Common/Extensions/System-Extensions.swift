//
//  Extensions.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/29.
//

import UIKit
import AVFoundation
import DateToolsSwift
 
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
//        return String((0..<len*-*gth).map{ _ in letters.randomElement()! })
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

extension Date{
    //本项目5种时间表示方式:
    //1.刚刚/5分钟前;2.今天21:10;3.昨天21:10;4.09-15;5.2019-09-15
    var formattedDate: String{
        let currentYear = Date().year
        if year == currentYear{//今年
            if isToday{//今天
                if minutesAgo > 10{//note发布(或存草稿)超过10分钟即显示'今天xx:xx'
                    return "今天 \(format(with: "HH:mm"))"
                }else{
                    return timeAgoSinceNow
                }
            }else if isYesterday{//昨天
                return "昨天 \(format(with: "HH:mm"))"
            }else{//前天或更早的时间
                return format(with: "MM-dd")
            }
        }else if year < currentYear{//去年或更早
            return format(with: "yyyy-MM-dd")
        }else{
            return "明年或更远,目前项目暂不会用到"
        }
    }
}


extension URL{
    //从视频中生成封面图(了解)
    var thumbnail: UIImage{
        let asset = AVAsset(url: self)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //如果视频尺寸确定的话可以用下面这句提高处理性能
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            return imagePH
        }
    }
}

extension UIImage{
    //初始化构造器三原则:
    //1.指定构造器必须调用它直接父类的指定构造器方法--见FollowVC
    //2.便利构造器必须调用同一个类中定义的其它初始化方法
    //3.便利构造器在最后必须调用一个指定构造器
    convenience init?(_ data: Data?) {
        if let unwrappedData = data{ 
            self.init(data: unwrappedData)
        }else{
            return nil
        }
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data?{
        jpegData(compressionQuality: jpegQuality.rawValue)
    }
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
    func showTextHUD(_ title: String, _ inCurrentView: Bool = true, _ subTitle: String? = nil){
        var viewToShow = view!
        if !inCurrentView{
            viewToShow = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: viewToShow, animated: true)
        hud.mode = .text //不指定的话显示菊花和下面配置的文本
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
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
 

extension FileManager{
    //对url添加子路径常用appendingPathComponent,对path添加就直接字符串拼接/插值
    func save(_ data: Data?, to dirName: String, as fileName: String) -> URL?{
        guard let data = data else {
            print("要写入的data为nil")
            return nil
        }
        
        // MARK: 知识点
        //1.path转URL,URL转path
        //2.创建文件夹和文件时都需要先规定URL
        //3.一般都会使用fileExists先判断文件夹或文件是否存在
        
        // MARK: 创建文件夹
        //"file:///xx/xx/tmp/dirName"
        //这里的URL(fileURLWithPath: NSTemporaryDirectory())也可使用temporaryDirectory
        let dirURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(dirName, isDirectory: true)
        
        if !fileExists(atPath: dirURL.path){
            guard let _ = try? createDirectory(at: dirURL, withIntermediateDirectories: true) else {
                print("创建文件夹失败")
                return nil
            }
        }
        
        // MARK: 写入文件
        //"file:///xx/xx/tmp/dirName/fileName"
        let fileURL = dirURL.appendingPathComponent(fileName)
        
        if !fileExists(atPath: fileURL.path){
            guard let _ = try? data.write(to: fileURL) else {
                print("写入/创建文件失败")
                return nil
            }
        }
        
        return fileURL
    }
}
