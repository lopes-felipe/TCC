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
    
    var lastButtonTag: Int?
    
    var newCommand: DeviceCommand?
    
    @IBOutlet var powerButton: UIButton!
    
    @IBAction func buttonPressed(sender:UIButton)
    {
        self.lastButtonTag = sender.tag
        
        guard let deviceCommand = selectedDevice.findCommandBy(layoutTag: sender.tag) else {
            let title = "Comando não cadastrado"
            let message = "Nenhum comando cadastrado para este botão. Deseja cadastrar um comando agora?"
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            let registerAction = UIAlertAction(title: "Cadastrar", style: .default, handler:registerNewCommand)
            
            let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertViewController.addAction(cancelAction)
            alertViewController.addAction(registerAction)
            
            present(alertViewController, animated: true, completion: nil)
            
            return
        }
        
        bluetoothCommunication.writeValue(value: [deviceCommand.manufacturerCode])
        bluetoothCommunication.writeValue(value: [deviceCommand.numberOfBits])
        bluetoothCommunication.writeValue(value: deviceCommand.data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func registerNewCommand(action: UIAlertAction) {
        newCommand = DeviceCommand(controlLayoutTag: lastButtonTag!)
        
        let alert = UIAlertController(title: "Aguardando", message: "Aguardando recebimento do comando...", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        bluetoothCommunication.receiveValue(delegate: self)
        
        // Envia flag de início de coleta do comando
        // TODO: Definir melhor forma de representar valor da flag
        bluetoothCommunication.writeValue(value: [255])
    }
    
    func didFinishRegistration(forCommand command:DeviceCommand) {
        self.selectedDevice.commands.append(command)
        
        dismiss(animated: false, completion: nil)    }
}

extension RemoteViewController : BluetoothReceiverDelegate {
    func bluetoothCommunication(bluetoothCommunication: BluetoothCommunication, didReceiveValue value: UInt8) {
        guard let command = newCommand else {
            return
        }
        
        if command.manufacturerCode == 0 {
            command.manufacturerCode = value
        }
        else if command.numberOfBits == 0 {
            command.numberOfBits = value
        }
        else {
            command.data.append(value)
            
            // Verifica se o comando já recebeu todos os dados
            if command.data.count == (Int)(command.numberOfBits / 8) {
                didFinishRegistration(forCommand: command)
            }
        }
        
    }
}

