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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定位
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 5

        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                    
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            if let location = location {
                print("location:%@", location)
            }
            
            if let reGeocode = reGeocode {
                print("reGeocode:%@", reGeocode)
            }
        })

    }
    

   

}


// MARK: - UITableViewDataSource
extension POIVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
//
//        let poi = pois[indexPath.row]
//        cell.poi = poi
//
//        if poi[0] == poiName{ cell.accessoryType = .checkmark }
//
//        return cell
        return UITableViewCell()
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
