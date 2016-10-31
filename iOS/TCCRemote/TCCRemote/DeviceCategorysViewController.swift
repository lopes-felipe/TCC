//
//  DeviceCategoriesViewController.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import UIKit

class DeviceCategoriesViewController
    : UITableViewController
{
    var deviceCategoriesManager: DeviceCategoriesManager!
    var bluetoothCommunication: BluetoothCommunication!
    
    var selectedDeviceCategory: DeviceCategory?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.deviceCategoriesManager = appDelegate.deviceCategoriesManager
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceCategoriesManager.deviceCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let deviceCategory = self.deviceCategoriesManager.deviceCategories[indexPath.row]
        
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = deviceCategory.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDeviceCategory = self.deviceCategoriesManager.deviceCategories[indexPath.row]
        
        performSegue(withIdentifier: "SelectedDeviceCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SelectedDeviceCategory") {
            let manufacturersViewController = segue.destination as! ManufacturersViewController
            
            manufacturersViewController.bluetoothCommunication = self.bluetoothCommunication
            manufacturersViewController.selectedDeviceCategory = self.selectedDeviceCategory
        }
    }
}
