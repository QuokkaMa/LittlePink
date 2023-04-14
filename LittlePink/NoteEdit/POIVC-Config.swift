//
//  POIVC-Config.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/11.
//

extension POIVC{
    func config(){
        
        //定位
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 5

        //搜索POI
        mapSearch?.delegate = self
        
        //配置refresh控件的三种方法,此处用第三种
        //1.闭包
        //tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {})
        //2.
        //tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(xxx))
        //3.设全局MJRefreshAutoNormalFooter,之后用他的setRefreshingTarget即可添加事件--此举方便自定义header和footer的样式
        tableView.mj_footer = footer
        
        //searchbar取消按钮一开始不生效的bug
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
    }
}
