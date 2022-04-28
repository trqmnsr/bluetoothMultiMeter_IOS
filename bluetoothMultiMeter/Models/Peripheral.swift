//
//  Peripheral.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/25/22.
//

import SwiftUI
import CoreBluetooth


class Peripheral: NSObject, Identifiable {
    
    let id: CBPeripheral
    private let central: BluetoothManager
    
    var name: String {id.name ?? "No Name"}
    
    @Published var rssiValue: RssiSignal
    
    init(peripheral: CBPeripheral, central: BluetoothManager) {
        id = peripheral
        rssiValue = .unusable
        self.central = central
        super.init()
        id.delegate = self
    }
    
    func connect() {
        if id.state != .connected {
            central.connect(Peripheral: self)
        }
        
    }
    
    func disconnect() {
        if id.state == .connected{
            central.disconnect(Peripheral: self)
        }
    }
    
    func discoverServices(peripheral: CBPeripheral) {
        peripheral.discoverServices([])
    }
     
    // Call after discovering services
    func discoverCharacteristics(peripheral: CBPeripheral) {
        guard let services = peripheral.services else {
            return
        }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func subscribeToNotifications(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        peripheral.setNotifyValue(true, for: characteristic)
     }
    
    func updaterssi(rssValue: NSNumber) {
        rssiValue = RssiSignal.getSignalFor(value: rssValue)
    }
    
    
}



// MARK: Peripheral Delegate
extension Peripheral: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        if error != nil {
            print(error.debugDescription)
        }
        rssiValue = RssiSignal.getSignalFor(value: RSSI)
    }
    
    
    func peripheral(peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: NSError?)
    {
        if (error != nil) {
            print(error!)
        } else {
            rssiValue = RssiSignal.getSignalFor(value: RSSI)
        }
    }
    
    
    // MARK: This function receives the data
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            // Handle error
            return
        }
        guard let value: Data = characteristic.value else {
            return
        }
        central.addPoint(y: Double(value[0]))
        
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            print("Error is discovering services for \(String(describing: peripheral.name))")
            return
        }
        discoverServices(peripheral: peripheral)
        discoverCharacteristics(peripheral: peripheral)
        
    }
    
    

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            print(error!)
            return
        }
        // Consider storing important characteristics internally for easy access and equivalency checks later.
        // From here, can read/write to characteristics or subscribe to notifications as desired.

        for characteristic in characteristics {
//            print("**Characteristic**\(characteristic.debugDescription)" )
            subscribeToNotifications(peripheral: peripheral, characteristic: characteristic)
            
        }
        
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            // Handle error
            return
        }
        // Successfully subscribed to or unsubscribed from notifications/indications on a characteristic
        //print("Did update Notification \(characteristic.debugDescription)")
       
    }
    

    
}
