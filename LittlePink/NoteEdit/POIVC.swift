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
    lazy var aroundSearchRequest :AMapPOIAroundSearchRequest = {
       let request = AMapPOIAroundSearchRequest()
        request.location =  AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        return request
    }()
    
    var pois = [["不显示位置", ""]]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var latitude = 0.0
    var longitude = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()
        
        mapSearch?.delegate = self

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
//            if request is AMapPOIAroundSearchRequest{
//                aroundSearchedPOIs.append(poi)
//            }
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
