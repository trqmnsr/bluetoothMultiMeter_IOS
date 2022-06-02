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
    
    @Published var availableModes: Set<PeripheralMode> = []
    
    @Published var isIncluded: Bool = true
    @Published var currentValue : Double = 0.0
    @Published var rssiValue: RssiSignal
    @Published var mode: PeripheralMode = .voltDC25
    
    
    var update: () -> Void = {}
    
    
    // MARK: Configuration Settings
    private var lineColor: CGColor = .getRandomColor()
    var color: CGColor {
        get{
            return lineColor
        }
        set {
            lineColor = newValue
            if let dataset = dataSet {
                dataset.colors = [UIColor(cgColor: newValue)]
            }
            update()
        }
    }
    
    private var lineWidth: Int = 3
    var linewidth: Int {
        get {
            return lineWidth
        }
        set {
            if 1...6 ~= newValue{
                lineWidth = newValue
                if let dataset = dataSet {
                    dataset.lineWidth = CGFloat( newValue)
                }}
            update()
        }
    }
    
    private var lineChartmode: LineChartDataSet.Mode = .linear
    var lineChartMode: LineChartDataSet.Mode {
        get {lineChartmode}
        set {
            lineChartmode = newValue
            if let dataset = dataSet {
                dataset.mode = newValue
            }
            update()
        }
    }
    
    private var showValue: Bool = true
    var showvalue: Bool {
        get {
            return showValue
        }
        set {
            showValue = newValue
            if let dataset = dataSet {
                dataset.drawValuesEnabled = newValue
            }
            update()
        }
    }
    
    private var showCircle: Bool = true
    var showcircle: Bool {
        get {
            return showCircle
        }
        set {
            showCircle = newValue
            if let dataset = dataSet {
                dataset.drawCirclesEnabled = newValue
            }
            update()
        }
    }
    
    private var circleColor: CGColor = .getRandomColor()
    var circlecolor: CGColor {
        get{
            return circleColor
        }
        set {
            circleColor = newValue
            if let dataset = dataSet {
                dataset.circleColors = [UIColor(cgColor: newValue)]
            }
            update()
        }
    }
    
    private var showHole: Bool = false
    var showhole: Bool {
        get {
            return showHole
        }
        set{
            showHole = newValue
            if let dataset = dataSet {
                dataset.drawCircleHoleEnabled = newValue
                dataset.circleHoleColor = newValue ?  UIColor(cgColor: holeColor) : .clear
            }
            update()
        }
    }
    
    private var holeColor: CGColor = .getRandomColor()
    var holecolor: CGColor {
        get{
            return holeColor
        }
        set {
            holeColor = newValue
            if let dataset = dataSet {
                dataset.circleHoleColor = UIColor(cgColor: newValue)
            }
            update()
        }
    }
    
    
    
    
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
        rssiValue.updateRssi(newRssiValue: rssValue)
    }
    
    func addPoint(_ data: Data) {
        let value = mode.formatData(data)
        currentValue = value
        if recordingState {
            if let dataset = dataSet {
                if recordingState {
                    let timeX = Peripheral.now() - timeZero
                    let newPoint = ChartDataEntry(x: timeX, y: value)
                    dataset.append(newPoint)
                    update()
                }
            }
        }
    }

    
    func getJSONData() -> Data? {
        guard let dataset = dataSet else {return nil}
        let points = dataset.entries.map({["x":$0.x,"y":$0.y]})
        let dictData: [String : Any] = [
            "title": name,
            "mode": mode.settings(),
            "xmin": dataset.xMin,
            "xmax": dataset.xMax,
            "ymin": dataset.yMin,
            "ymax": dataset.yMax,
            "points": points
        ]
        do {
            if JSONSerialization.isValidJSONObject(dictData) {
                let data = try JSONSerialization.data(withJSONObject: dictData, options: .prettyPrinted)
                return data
            } else {
                print("not valid json")
            }
            
        } catch {
            print(error)
        }
        
        return nil
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

    
    
    // MARK: This function receives the data
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data: Data = characteristic.value else {
            return
        }
        
        addPoint(data)
        
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
        peripheral.readRSSI()
        // Successfully subscribed to or unsubscribed from notifications/indications on a characteristic
        //print("Did update Notification \(characteristic.debugDescription)")
    }
}
