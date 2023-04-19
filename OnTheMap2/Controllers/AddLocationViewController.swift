//
//  AddLocationViewController.swift
//  OnTheMap2
//
//  Created by Pantos, Thomas on 13/3/23.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController, UITextFieldDelegate {
    
    let confirmMapLocationSegueId = "confirmMapLocationSegue"
    var newLocation = CLLocationCoordinate2D()
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        self.errorLabelView.isHidden = true
        self.urlTextField.delegate = self
        self.locationTextField.delegate = self
        
    }

    //MARK: Location Button Pressed
    @IBAction func findLocationRequest(_ sender: Any) {
        if self.urlTextField.text == nil || self.urlTextField.text == "" {
            self.showErrorAlert("Please provide a URL for this location.")
        } else {
            let geoCoder = CLGeocoder()
            self.activityIndicator.isHidden = false
            
            geoCoder.geocodeAddressString(self.locationTextField.text ?? "", completionHandler: { (placemark, error) in
                if error != nil {
                    self.showErrorAlert(error!.localizedDescription)
                    self.activityIndicator.isHidden = true
                } else {
                    if let newPlacemark = placemark?.first, let newLoc = newPlacemark.location?.coordinate {
                        self.newLocation = newLoc
                        self.performSegue(withIdentifier: self.confirmMapLocationSegueId, sender: self)
                    } else {
                        print("Error in digging for Coordinate!")
                    }
                }
            })
        }
        
    }
    //MARK: cancel
    @IBAction func cancelNewLocation(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    //MARK: Error Alert
    func showErrorAlert(_ message: String) {
        self.errorLabelView.text = "ERROR: \(message)"
        self.errorLabelView.isHidden = false
    }
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.confirmMapLocationSegueId {
            
            let controller = segue.destination as! ConfirmLocationViewController
            controller.newLocation = self.newLocation
            controller.newLocationString = self.locationTextField.text ?? ""
            controller.newLocationURL = URL(string: self.urlTextField.text ?? "")
        }
    }

}
