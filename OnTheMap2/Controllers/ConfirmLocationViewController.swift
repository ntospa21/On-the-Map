//
//  ConfirmLocationViewController.swift
//  OnTheMap2
//
//  Created by Pantos, Thomas on 13/3/23.
//

import UIKit
import MapKit


class ConfirmLocationViewController: UIViewController, MKMapViewDelegate {
    //MARK: Map Data
    var newLocation = CLLocationCoordinate2D()
    var newLocationString = ""
    var newLocationURL = URL(string: "")
    var proposedAnnotation = MKPointAnnotation()

    //MARK: Outlets
    @IBOutlet weak var confirmMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set delegate
        self.confirmMapView.delegate = self
        //build annotation
        self.proposedAnnotation.coordinate = self.newLocation
        self.proposedAnnotation.title = newLocationString
        self.proposedAnnotation.subtitle = newLocationURL?.absoluteString
        //set annotation on map view
        self.confirmMapView.centerCoordinate = self.newLocation
        
        self.confirmMapView.addAnnotations([proposedAnnotation])
        let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude), span: span)
        self.confirmMapView.setRegion(region, animated: true)
        
    }
    

    @IBAction func finishAndPost(_ sender: Any) {
        // post new student location
        UdacityAPI.postNewStudenLocation(newLatitude: self.newLocation.latitude, newLongitude: self.newLocation.longitude, locationString: self.newLocationString, locationMediaURL: self.newLocationURL?.absoluteString ?? "",  completion: {(results, error) in
            if error != nil {

                // handle error
                
                self.showConfirmFailure(message: error!.localizedDescription)
            } else {
                // handle results
                return
                
                
            }
        })
        // update map data
        UdacityAPI.getMapDataRequest(completion: { (studentLocationsArray, error) in
            if error != nil {
                self.showConfirmFailure(message: error!.localizedDescription)
            } else {
                MapPins.mapPins = studentLocationsArray
                self.dismiss(animated: true, completion: {})
            }
        })

    }
    
    func showConfirmFailure(message: String ) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
}
