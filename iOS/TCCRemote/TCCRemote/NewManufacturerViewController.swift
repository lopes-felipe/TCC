//
//  NewManufacturerViewController.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/30/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import UIKit

class NewManufacturerViewController
    : UIViewController, UITextFieldDelegate {
    
    var currentCategory: DeviceCategory?
    
    @IBOutlet weak var manufacturerField: UITextField!
    
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
        guard let manufacturerName = manufacturerField.text else {
            // TODO: Exibir erro
            return;
        }
        
        let manufacturer = Manufacturer(name: manufacturerName)
        self.currentCategory?.manufacturers.append(manufacturer)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }    
}
