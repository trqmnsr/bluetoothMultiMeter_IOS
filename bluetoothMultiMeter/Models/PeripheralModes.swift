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
            return PeripheralSetting(title: "Volt", units: "VDC", maxValue: 25.0, minValue: 0.0 )
        case .amp30:
            return PeripheralSetting(title: "Amps", units: "A", maxValue: 30.0, minValue: -30.0)
        case .res0:
            return PeripheralSetting(title: "Resistance", units: "Ω", maxValue: 1000000000.0, minValue: 0.0)
        case .unknown:
            return PeripheralSetting(title: "Unknown", units: "Unit", maxValue: 130.0, minValue: 0.0 )
        }
    }
    
    func getMultiplier() -> Double {
        switch self {
        case .voltDC25:
            return 0.001
        case .amp30:
            return 0.001
        case .res0:
            return 1
        case .unknown:
            return 1
        }
    }
    
    func getCalculatedValue(value: Int16) -> Double {
        var multiplier : Double = 1.0
        let val = Double(value)
        
        switch self {
        case .voltDC25:
            multiplier = 0.001
        case .amp30:
            multiplier =  0.001
        case .res0:
            multiplier =  1.0
        case .unknown:
            multiplier =  1.0
        }
        
        return multiplier * val
    }
    
    mutating func changeMode(modeIndex: Int){
        switch modeIndex {
        case 2:
            self = .voltDC25
        case 3:
            self = .amp30
        case 4:
            self = .res0
        default:
            self = .unknown
        }
    }
    
    static func getModeFromInt(modeIndex: Int) -> PeripheralMode{
        switch modeIndex {
        case 2:
            return PeripheralMode.voltDC25
        case 3:
            return PeripheralMode.amp30
        case 4:
            return PeripheralMode.res0
        default:
            return PeripheralMode.unknown
        }
    }
}



