//
//  NewDeviceViewController.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/31/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import UIKit

class NewDeviceViewController
    : UIViewController {
    
    var currentManufacturer: Manufacturer?
    
    @IBOutlet weak var deviceField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        guard let deviceName = deviceField.text else {
            // TODO: Exibir erro
            return;
        }
        
        let device = Device(name: deviceName)
        self.currentManufacturer?.devices.append(device)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
