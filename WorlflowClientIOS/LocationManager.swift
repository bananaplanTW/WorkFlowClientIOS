//
//  LocationManager.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/15/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager {
    class func sharedInstance () -> LocationManager {
        struct Static {
            static let instance: LocationManager = LocationManager()
        }
        return Static.instance
    }

    private var address: String = "搜尋中.."
    private let locMgr: CLLocationManager!
    private init () {
        locMgr = CLLocationManager()
    }


    func getLocationManager() -> CLLocationManager {
        return locMgr
    }
    func setAddress(address: String) {
        self.address = address
    }
    func getAddress() -> String {
        return self.address
    }


    func parseAddress(placemark: CLPlacemark) -> String {
        let administractiveArea: String = (placemark.administrativeArea != nil) ? placemark.administrativeArea! : ""
        let thoroughfare: String = (placemark.thoroughfare != nil) ? placemark.thoroughfare! : ""
        return administractiveArea + thoroughfare
    }
}