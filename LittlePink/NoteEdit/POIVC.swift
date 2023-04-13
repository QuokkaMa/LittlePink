//
//  POIVC.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/10.
//

import UIKit

class POIVC: UIViewController {

    lazy var locationManager = AMapLocationManager() //定位用
    lazy var mapSearch = AMapSearchAPI() //搜索POI用
    //搜索周边POI请求
    lazy var aroundSearchRequest :AMapPOIAroundSearchRequest = {
       let request = AMapPOIAroundSearchRequest()
        request.location =  AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.types = kPOITypes
        return request
    }()
    //关键字搜索POI请求
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.offset = kPOIsOffset
        return request
    }()
    
    //因页面一开始在cell中有数组取值处理，必须规定内嵌的数组有两个元素，若元素数量动态的话可用下面repeating方法
    var pois = kPOIsInitArr
    var aroundSearchedPOIs = kPOIsInitArr //完全同步copy周边的pois数组，用于简化逻辑
    
    // 经纬度
    var latitude = 0.0
    var longitude = 0.0
    // 搜索关键字内容
    var keywords = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()
        
        mapSearch?.delegate = self
    }

}

extension POIVC: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {dismiss(animated: true)}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            //重置(reset)
            pois = aroundSearchedPOIs //恢复为之前周边搜索的数据
            tableView.reloadData()
        }
    }
    
    // MARK: 关键字搜索POI
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        
        keywords = searchText
        pois.removeAll()
        showLoadHUD()
        keywordsSearchRequest.keywords = keywords
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
        
    }
    
}


extension POIVC: AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {

        hideLoadHUD()
        
        if response.count == 0 {return}
        
        for poi in response.pois{
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.district == poi.address ? "" : poi.address
            
            let poi = [
                poi.name ?? kNoPOIPH,
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"
            ]
            pois.append(poi)
            if request is AMapPOIAroundSearchRequest{
                aroundSearchedPOIs.append(poi)
            }
        }
        
        tableView.reloadData()
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
//        let cell = tableView.cellForRow(at: indexPath)!
//        cell.accessoryType = .checkmark
//
//        delegate?.updatePOIName(pois[indexPath.row][0])
//
//        dismiss(animated: true)
    }
}
