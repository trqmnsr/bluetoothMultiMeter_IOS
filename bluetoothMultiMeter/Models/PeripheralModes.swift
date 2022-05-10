//
//  PeripheralModes.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/4/22.
//

import Foundation

struct PeripheralSetting {
    
    let title: String
    let units: String
    let maxValue: Double
    let minValue: Double
    
}

enum PeripheralMode {
    case voltDC25
    case amp30
    case res0
    case unknown
    
    func settings() -> PeripheralSetting {
        switch self {
        case .voltDC25:
            return PeripheralSetting(title: "VoltMeter", units: "VDC", maxValue: 25.0, minValue: 0.0 )
        case .amp30:
            return PeripheralSetting(title: "Amperemeter", units: "A", maxValue: 30.0, minValue: -30.0)
        case .res0:
            return PeripheralSetting(title: "Resistance", units: "Ω", maxValue: 1000000000.0, minValue: 0.0)
        case .unknown:
            return PeripheralSetting(title: "Unknown", units: "Unit", maxValue: 130.0, minValue: 0.0 )
        }
    }
    
    mutating func changeMode(modeIndex: Int){
        switch modeIndex {
        case 0:
            self = .voltDC25
        case 1:
            self = .amp30
        case 2:
            self = .res0
        default:
            self = .unknown
        }
    }
}



