//
//  Constants.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/19/22.
//

import Foundation
import CoreBluetooth

enum Constants: CaseIterable {
    static let readServiceUUID: CBUUID = .init(string: "FFD0")
    static let writeServiceUUID: CBUUID = .init(string: "FFD5")
    static let serviceUUIDs: [CBUUID] = [readServiceUUID, writeServiceUUID]
    static let readCharacteristicUUID: CBUUID = .init(string: "FFD4")
    static let writeCharacteristicUUID: CBUUID = .init(string: "FFD9")
}
