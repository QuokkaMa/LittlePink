//
//  POIVC.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/10.
//

import UIKit

class POIVC: UIViewController {

    
    var delegate: POIVCDelegate?
    var poiName = ""
    
    lazy var locationManager = AMapLocationManager() //定位用
    lazy var mapSearch = AMapSearchAPI() //搜索POI用
    //搜索周边POI请求
    lazy var aroundSearchRequest :AMapPOIAroundSearchRequest = {
       let request = AMapPOIAroundSearchRequest()
        request.types = kPOITypes
        request.location =  AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.offset = kPOIsOffset
        return request
    }()
    //关键字搜索POI请求
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.offset = kPOIsOffset
        return request
    }()
    lazy var footer = MJRefreshAutoNormalFooter() //默认样式的上拉加载控件(控件会随着cell走)
    
    //因页面一开始在cell中有数组取值处理，必须规定内嵌的数组有两个元素，若元素数量动态的话可用下面repeating方法
    var pois = kPOIsInitArr
    var aroundSearchedPOIs = kPOIsInitArr //完全同步copy周边的pois数组，用于简化逻辑
    
    // 经纬度
    var latitude = 0.0
    var longitude = 0.0
    // 搜索关键字内容
    var keywords = ""
    var currentAroundPage = 1 //周边搜索的当前页数
    var currentKeywordsPage = 1 //关键字搜索的当前页数
    var pageCount = 1 //所有搜索的总页数
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()
    }

}


    
    
// MARK: - UITableViewDataSource
extension POIVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { pois.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell

        let poi = pois[indexPath.row]
        cell.poi = poi

        return cell
    }
}

// MARK: - UITableViewDelegate
extension POIVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark

        delegate?.updatePOIName(pois[indexPath.row][0])

        dismiss(animated: true)
    }
}

// MARK: - 一般函数
extension POIVC{
    func endRefreshing(_ currentPage: Int){
        if currentPage < pageCount{
            footer.endRefreshing() //结束上拉加载小菊花的UI
        }else{
            footer.endRefreshingWithNoMoreData() //展示加载完毕UI，并使上拉加载功能失效（不触发@obj的方法了）
        }
    }
}
