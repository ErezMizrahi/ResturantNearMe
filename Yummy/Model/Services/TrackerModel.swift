//
//  TrackerModel.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import CoreLocation


protocol ILocationService {
    func startLocationService()
    func StopLocationService()
    var currentLocation: CLLocation? { get }
    var callback: locationCallback? { get set }
}

typealias locationCallback = ((Result<CLLocation>)->Void)

enum Result<T> {
    case succsess(T)
    case failure(Error)
}

 class TrackerModel: NSObject {
    static let shared = TrackerModel()

    let manager: CLLocationManager
    var callback: locationCallback?
    var isMonitoring: Bool
    
     override init() {
        self.manager = CLLocationManager()
        isMonitoring = false

        super.init()
        manager.delegate = self
        callback = nil
    }
   
}


extension TrackerModel: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if isMonitoring {
            self.startLocationService()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       callback?(.failure(error))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        callback?(.succsess(locations[0]))
    }
    
}

extension TrackerModel: ILocationService {
 
    func startLocationService() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            isMonitoring = true
            manager.requestLocation()
        case .denied, .restricted:
            isMonitoring = false
            break
        case .notDetermined:
            isMonitoring = false
            manager.requestWhenInUseAuthorization()
        
        }
    }
    
    func StopLocationService() {
        manager.stopUpdatingLocation()
    }
    
    var currentLocation: CLLocation? {
        return manager.location
    }
    
    
}
