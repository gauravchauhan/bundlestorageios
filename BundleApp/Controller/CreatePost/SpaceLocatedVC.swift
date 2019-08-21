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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.setRightBarButtonItems(Step: "02")
        self.setBackButtonWithTitle(title: "Create")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click_AddressTextField(_ sender: Any) {
//        print("In Search Biutton Click")
//        let autocompleteController = GMSAutocompleteViewController()
//        autocompleteController.delegate = self
//        present(autocompleteController, animated: true, completion: nil)
        self.pushToDescribeListingController()
    }
    
    
    
}

extension SpaceLocatedVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place \(place.name)")
        print("Places \(String(describing: place.formattedAddress))")
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
//        filter.country = "IN"
        
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
