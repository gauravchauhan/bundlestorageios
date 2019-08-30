//
//  Location.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation
import CoreLocation

class Location : NSObject, CLLocationManagerDelegate{
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    func setLatLong(){
        DispatchQueue.main.async {
            if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                self.currentLocation = self.locManager.location
                self.locManager.delegate = self
                self.locManager.startUpdatingLocation()
                print("Location Class Latitude  \(self.currentLocation.coordinate.latitude)")
                print("Location Class Latitude \(self.currentLocation.coordinate.longitude)")
                Singelton.sharedInstance.currentLatitude = self.currentLocation.coordinate.latitude
                Singelton.sharedInstance.currentLongitude = self.currentLocation.coordinate.longitude
            }else{
                self.locManager.delegate = self
                self.locManager.requestAlwaysAuthorization()
                self.locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                  //  Singelton.sharedInstance.location.setLatLong()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called \(locations)")
        //store the user location here to firebase or somewhere
    }
    
    
    
    
}

