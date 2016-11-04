//
//  NewItemViewController.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/30/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import UIKit

class NewCategoryViewController
    : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var categoryField: UITextField!
    
    override func viewDidLoad() {
        categoryField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: AnyObject) {
        categoryField.resignFirstResponder()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        guard let categoryName = categoryField.text else {
            // TODO: Exibir erro
            return;
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deviceCategoriesManager?.add(deviceCategory: categoryName)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
