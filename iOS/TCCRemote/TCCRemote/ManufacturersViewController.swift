//
//  ManufacturersViewController.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/25/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import UIKit

class ManufacturersViewController
    : UITableViewController
{
    var bluetoothCommunication: BluetoothCommunication!
    var selectedDeviceCategory: DeviceCategory!
    var selectedManufacturer: Manufacturer!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedDeviceCategory.manufacturers.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let manufacturer = self.selectedDeviceCategory.manufacturers[indexPath.row]
        
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = manufacturer.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedManufacturer = self.selectedDeviceCategory.manufacturers[indexPath.row]

        performSegue(withIdentifier: "SelectedManufacturer", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.selectedDeviceCategory.manufacturers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectedManufacturer" {
            let remoteViewController = segue.destination as! DevicesViewController
        
            remoteViewController.bluetoothCommunication = self.bluetoothCommunication
            remoteViewController.selectedManufacturer = self.selectedManufacturer
        }
        else if segue.identifier == "NewItem" {
            let newManufacturerViewController = segue.destination as! NewManufacturerViewController
            
            newManufacturerViewController.currentCategory = self.selectedDeviceCategory
        }
    }
}
