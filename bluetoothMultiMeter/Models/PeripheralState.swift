//
//  PeripheralState.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/28/22.
//

import Foundation
import CoreBluetooth


extension CBPeripheralState {
    
    func toString() -> String {
        
        switch self {
            
        case .disconnected:
            return "Disconnected"
        case .connecting:
            return "Connecting"
        case .connected:
            return "Connected"
        case .disconnecting:
            return "Disconnecting"
        @unknown default:
            return "Unknown State"
            
        }
    }
    
}
