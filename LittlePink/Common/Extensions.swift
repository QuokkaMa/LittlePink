//
//  Extensions.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/29.
//

import UIKit

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

extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
 
