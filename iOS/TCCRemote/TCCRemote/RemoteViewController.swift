//
//  ViewController.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/11/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import UIKit

class RemoteViewController: UIViewController {

    var bluetoothCommunication: BluetoothCommunication!
    var selectedDevice: Device!
    
    @IBOutlet var powerButton: UIButton!
    
    @IBAction func buttonPressed(sender:UIButton)
    {
        let deviceCommand = selectedDevice.commands[0];
        
        bluetoothCommunication.writeValue(value: [selectedDevice.manufacturer!.code])
        bluetoothCommunication.writeValue(value: [deviceCommand.numberOfBits])
        bluetoothCommunication.writeValue(value: deviceCommand.data)
        
        /*
        bluetoothCommunication.writeValue(value: Int8(self.selectedManufacturer.code))
        bluetoothCommunication.writeValue(value: Int8(sender.tag))
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

