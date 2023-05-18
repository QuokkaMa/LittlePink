//
//  NearByVC.swift
//  LittlePink
//  首页 - 附近页面
//  Created by 马振洲 on 2023/1/9.
//

import UIKit
import XLPagerTabStrip

class NearByVC: UIViewController, IndicatorInfoProvider {
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 44, width: 300, height: 300))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "附近")
    }
}
