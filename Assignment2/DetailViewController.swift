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
    
    var activeField: UITextField?
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
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        
        let tap =  UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        // move the screen when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardhide(notifacation:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
    }
    
    @objc func keyboardhide(notifacation:Notification){
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.delegate = self
        addressTextField.delegate = self
        longTextField.delegate = self
        latTextField.delegate = self
        
        self.activeField = UITextField()
        
    }
    
    @objc func keyboardWillShow(notification: Notification){
        guard let keyboardInfo = notification.userInfo else{return}
        if let keyboardSize = (keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size{
            let keyboardHeight = keyboardSize.height + 10
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollView.contentInset = contentInsets
            var viewRect = self.view.frame
            viewRect.size.height -= keyboardHeight
            guard let activeField = self.activeField else {return}
            if(!viewRect.contains(activeField.frame.origin)){
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardHeight)
                self.scrollView.setContentOffset(scrollPoint, animated: true)
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
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
        self.activeField = nil

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
            self.delegate?.reload()
            
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

