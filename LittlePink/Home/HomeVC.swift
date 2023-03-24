//
//  HomeVC.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/9.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        
        // MARK: selectedBar --- 按钮下方的条
        settings.style.selectedBarBackgroundColor = UIColor(named : "mainColor")!
        settings.style.selectedBarHeight = 3

        // buttonBar item 属性
        // 背景颜色
        settings.style.buttonBarItemBackgroundColor = .clear
        // 文字颜色
        settings.style.buttonBarItemTitleColor = .label
        // 文字大小
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
        
        // 帮助确定单元格宽度，它表示标题标签之前和之后的空间
        settings.style.buttonBarItemLeftRightMargin = 0

        // 如果barView项没有填充屏幕宽度，此属性拉伸单元格以填充屏幕
        // settings.style.buttonBarItemsShouldFillAvailiableWidth = true

        // 仅用于以编程方式创建按钮栏，而不使用故事板或推荐的nib文件。
        // public var buttonBarHeight: CGFloat?
        
        
        super.viewDidLoad()
        
        // UIScrollView 到两侧无法再拉
        containerView.bounces = false

        // 设置未选中与选中的字体颜色
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
        
        // 主线程运行
        DispatchQueue.main.async {
            // 设置默认选中栏
            self.moveToViewController(at: 1,animated: false)
            
        }
        
    }

    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = storyboard!.instantiateViewController(withIdentifier: kFollowVCID)
        let discoveryVC = storyboard!.instantiateViewController(withIdentifier: kDiscoveryVCID)
        let nearByVC = storyboard!.instantiateViewController(withIdentifier: kNearByVCID)
        return [discoveryVC, followVC, nearByVC]
    }

}
