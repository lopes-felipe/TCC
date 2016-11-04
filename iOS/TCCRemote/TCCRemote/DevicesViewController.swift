//
//  DevicesViewController.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import UIKit

class DevicesViewController
    : UITableViewController {
    
    var bluetoothCommunication: BluetoothCommunication!
    var selectedManufacturer: Manufacturer!
    var selectedDevice: Device!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedManufacturer.devices.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let device = self.selectedManufacturer.devices[indexPath.row]
        
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = device.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDevice = self.selectedManufacturer.devices[indexPath.row]
        
        performSegue(withIdentifier: "SelectedDevice", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.selectedManufacturer.devices.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SelectedDevice") {
            let remoteViewController = segue.destination as! RemoteViewController
            
            remoteViewController.bluetoothCommunication = self.bluetoothCommunication
            remoteViewController.selectedDevice = self.selectedDevice
        }
        else if segue.identifier == "NewItem" {
            let newDeviceViewController = segue.destination as! NewDeviceViewController
            
            newDeviceViewController.currentManufacturer = self.selectedManufacturer
        }
    }
}
