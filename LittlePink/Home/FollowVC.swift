//
//  FollowVC.swift
//  LittlePink
//  首页 - 关注页面
//  Created by 马振洲 on 2023/1/9.
//

import UIKit
import XLPagerTabStrip

class FollowVC: UIViewController , IndicatorInfoProvider {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "关注")
    }
}
