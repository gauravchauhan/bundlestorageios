//
//  SpaceLocatedVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class SpaceLocatedVC: UIViewController {
    
    @IBOutlet weak var addressMapView: GMSMapView!
    @IBOutlet weak var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.setRightBarButtonItems(Step: "02")
        self.setBackButtonWithTitle(title: "Create")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click_AddressTextField(_ sender: Any) {
        print("In Search Biutton Click")
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    @IBAction func click_NextButton(_ sender: Any) {
        guard let address : String = self.address.text , address != "" else {
            return alert(message: NSLocalizedString("Enter address", comment: ""), Controller: self)
        }
        self.pushToDescribeListingController(fromWhichScreen: "spaceLocated")
    }
}

extension SpaceLocatedVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.address.text! =  place.formattedAddress!
        let position = CLLocationCoordinate2D(latitude: place.coordinate.latitude , longitude: place.coordinate.longitude)
        self.addressMapView.addMarker(position: position, title: "\(place.name)")
        let location = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude,
                                              longitude: place.coordinate.longitude,
                                              zoom: 6)
        self.addressMapView.camera = location
        Singelton.sharedInstance.addStorageModal.storageAddress = self.address.text!
        Singelton.sharedInstance.addStorageModal.storageLatitude = place.coordinate.latitude
        Singelton.sharedInstance.addStorageModal.storageLongitude = place.coordinate.longitude
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        //        placeAutocomplete()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func placeAutocomplete() {
        
        let   placesClient = GMSPlacesClient()
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        placesClient.autocompleteQuery("New Delhi", bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                for result in results {
                    print("Result \(result.attributedFullText) with placeID \(String(describing: result.placeID))")
                    
                }
            }
        })
    }
    
}
