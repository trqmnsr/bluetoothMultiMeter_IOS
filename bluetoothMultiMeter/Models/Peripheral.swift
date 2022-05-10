//
//  Peripheral.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/25/22.
//

import SwiftUI
import CoreBluetooth
import Charts


class Peripheral: NSObject, Identifiable, ObservableObject {
    
    let id: CBPeripheral
    
    private let central: BluetoothManager
    var dataSet: LineChartDataSet!
    
    var name: String {id.name ?? "No Name"}
    private var recordingState = false
    private var timeZero: Double = 0.0
    @Published var isIncluded: Bool = true
    @Published var currentValue = 0.00
    @Published var rssiValue: RssiSignal
    @Published var mode: PeripheralMode = .unknown
    @Published var colour: CGColor = .init(
        red: .random(in: ClosedRange(uncheckedBounds: (lower: 0.0, upper: 1.0)) ),
        green: .random(in: ClosedRange(uncheckedBounds: (lower: 0.0, upper: 1.0)) ),
        blue: .random(in: ClosedRange(uncheckedBounds: (lower: 0.0, upper: 1.0)) ),
        alpha: 1)
    var color: CGColor {
        get{
            return colour
        }
        set(newcolor) {
            colour = newcolor
            if let dataset = dataSet {
                dataset.colors = [UIColor(cgColor: newcolor)]
            }
        }
    }
    
    var update: () -> Void = {}
    
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
    
    func addPoint(value: Double) {
        
        currentValue = value
        if recordingState {
            if let dataset = dataSet {
                if recordingState {
                    let timeX = Peripheral.now() - timeZero
                    //print("x: \(timeX), y: \(value)")
                    let newPoint = ChartDataEntry(x: timeX, y: value)
                    dataset.append(newPoint)
                    update()
                }
            }
        }
    }
    
    func getData() -> Void {
        guard let dataset = dataSet else {return}
        dataset.entries
        
    }

    
    func startRecord(dataset newdata: LineChartDataSet, updater: @escaping ()-> Void ){
        dataSet = newdata
        timeZero = Peripheral.now()
        recordingState = true
        update = updater
    }
    
    func stopRecording() {
        recordingState = false
    }
    
    private func decodeDataToInteger(data: Data) -> Int {
        return 1
    }
    
    
    private static func now() -> Double{
        return Double(DispatchTime.now().uptimeNanoseconds) / 1000000000
        
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
        guard let data: Data = characteristic.value else {
            return
        }
        var modenum: Int = 0
        var value: Double = 0.0
        
        data.withUnsafeBytes({
            modenum = Int($0[2])
            value = Double($0.load(as: Int16.self))/1000
            
        })
        
        //print("Mode: \(mode) Value: \(value)")
        mode.changeMode(modeIndex: modenum)
        addPoint(value: value)
        
        
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
