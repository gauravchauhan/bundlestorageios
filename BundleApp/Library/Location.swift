//
//  Location.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation
import CoreLocation

protocol CurrentLocationDelegate {
    func currentLocationResponse(lat : CLLocationDegrees , lng : CLLocationDegrees)
    func LocationPermissionDenied()
}

class Location : NSObject, CLLocationManagerDelegate{
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var current_Delegate : CurrentLocationDelegate!
    
    func setLatLong(){
        DispatchQueue.main.async {
            if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                self.currentLocation = self.locManager.location
                self.locManager.delegate = self
//                self.locManager.startUpdatingLocation()
//                print("Location Class Latitude  \(self.currentLocation.coordinate.latitude)")
//                print("Location Class Latitude \(self.currentLocation.coordinate.longitude)")
//                Singelton.sharedInstance.currentLatitude = self.currentLocation.coordinate.latitude
//                Singelton.sharedInstance.currentLongitude = self.currentLocation.coordinate.longitude
//                self.delegate.getLocationResponse(status: true)
            }else{
                self.locManager.delegate = self
                self.locManager.requestAlwaysAuthorization()
                self.locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            }
        }
    }
    
    func getCurrentLocation(){
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            self.current_Delegate.currentLocationResponse(lat: self.currentLocation.coordinate.latitude, lng: self.currentLocation.coordinate.longitude)
        }else{
            self.current_Delegate.LocationPermissionDenied()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print("Authorisation")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called \(locations)")
        self.currentLocation = manager.location
        //store the user location here to firebase or somewhere
    }
    
    
    
    
}

