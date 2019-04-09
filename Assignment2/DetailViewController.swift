//
//  DetailViewController.swift
//  Assignment2
//
//  Created by Min young Go on 9/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    
    var delegate : detailCancel? = nil
    var backups: Location?
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        guard let di = detailItem else{return}
        guard let backup = backups else {return}
        
        di.address = backup.address
        di.name = backup.name
        di.long = backup.long
        di.lat = backup.lat
        delegate?.cancel()
       
        
       
    }
    
    var detailIndex = 0
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var latTextField: UITextField!
    
    func configureView() {
        
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let name = nameTextField {
                name.text = detail.name
            }
            if let address = addressTextField {
                address.text = detail.address
            }
            if let long = longTextField {
                long.text = detail.long
            }
            if let lat = latTextField {
                lat.text = detail.lat
            }
            
            guard let latString = Double(detail.long), let longString = Double(detail.long) else{return}
            backups = Location(name: detail.name, address: detail.address, long: longString, lat: latString)
            
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        addressTextField.delegate = self
        longTextField.delegate = self
        latTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
    }

    var detailItem: Location? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let di = detailItem, let dn = nameTextField.text, let da = addressTextField.text else {return}
        
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressTextField.text!) {
            placemarks, error in
            let placemark = placemarks?.first
            guard
                let lat = placemark?.location?.coordinate.latitude,
                let lon = placemark?.location?.coordinate.longitude
                else{
                    return
            }
            self.longTextField.text! = "\(lon)"
            self.latTextField.text! = "\(lat)"
            di.long = "\(lon)"
            di.lat = "\(lat)"

            
            

        }
        
        
        
        
        // Considers the values within the fields
        switch textField {
        case nameTextField:
            di.name = dn
        case addressTextField:
            di.address = da
       
        default:
            print("Unknown Field")
        }
        
        
      
        
    }
   
    
    
    
    
}

