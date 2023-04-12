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

    }
}
