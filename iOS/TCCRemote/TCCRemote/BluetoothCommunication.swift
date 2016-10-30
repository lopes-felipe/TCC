import CoreBluetooth

protocol BluetoothCommunicationDelegate: class {
    func bluetoothCommunication(bluetoothCommunication: BluetoothCommunication, didReceiveValue value: Int8)
    
    func bluetoothCommunicationDidConnect(bluetoothCommunication: BluetoothCommunication)
}

class BluetoothCommunication: NSObject {
    let serviceUUID: String
    weak var delegate: BluetoothCommunicationDelegate?
    
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    var targetService: CBService?
    var writableCharacteristic: CBCharacteristic?
    
    init(serviceUUID: String, delegate: BluetoothCommunicationDelegate?) {
        self.serviceUUID = serviceUUID
        self.delegate = delegate
        
        super.init()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func writeValue(value: [UInt8]) {
        guard let peripheral = connectedPeripheral, let characteristic = writableCharacteristic else {
            return
        }
        
        let data = Data(bytes: value)
        peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
    }
    
}

extension BluetoothCommunication: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            //centralManager.scanForPeripheralsWithServices([CBUUID(string: serviceUUID)], options: nil)
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        debugPrint("centralManager::didDiscoverPeripheral: ")
        
        if let peripheralName = peripheral.name {
            debugPrint(peripheralName)
            debugPrint(peripheral.identifier.uuidString)
        }
        
        connectedPeripheral = peripheral
        
        if let connectedPeripheral: CBPeripheral = connectedPeripheral, connectedPeripheral.identifier.uuidString == "A163B9B9-0B57-0993-82CA-3C621BBA467E" {
            connectedPeripheral.delegate = self
            centralManager.connect(connectedPeripheral, options: nil)
            centralManager.stopScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        debugPrint("centralManager::didConnectPeripheral: ")
        
        if let peripheralName = peripheral.name {
            debugPrint(peripheralName)
        }
        
        peripheral.discoverServices(nil)
    }
}

extension BluetoothCommunication: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            return
        }
        
        targetService = services.first
        if let service = services.first {
            targetService = service
            
            debugPrint("peripheral::didDiscoverServices: ", targetService.debugDescription)
            
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            return
        }
        
        for characteristic in characteristics {
            if characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse) {
                writableCharacteristic = characteristic
                
                debugPrint("centralManager::didDiscoverCharacteristicsForService")
                delegate?.bluetoothCommunicationDidConnect(bluetoothCommunication: self)
                
            }
            
            //peripheral.setNotifyValue(true, forCharacteristic: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value, let delegate = delegate else {
            return
        }
        
        // delegate.bluetoothCommunication(bluetoothCommunication: self, didReceiveValue: data.int8Value())
    }
}
