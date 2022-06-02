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
    let defaultOn: Bool
    
}

enum PeripheralMode: CaseIterable, Identifiable {
    
    case voltDC25
    case amp30
    case res0
    
    var id: Self { self }
    
    func settings() -> PeripheralSetting {
        switch self {
        case .voltDC25:
            return PeripheralSetting(title: "Volt", units: "VDC", maxValue: 25.0, minValue: 0.0, defaultOn: true )
        case .amp30:
            return PeripheralSetting(title: "Current", units: "A", maxValue: 30.0, minValue: -30.0, defaultOn: false)
        case .res0:
            return PeripheralSetting(title: "Resistance", units: "Ω", maxValue: 1000000000.0, minValue: 0.0, defaultOn: false)
        }
    }
    
    
    mutating func changeMode(_ newMode: PeripheralMode){
        print("Channging Mode to \(newMode)")
        self = newMode
    }
    
    
    func formatData(_ data: Data) -> Double {
        var value: Double = Double()
        
        data.withUnsafeBytes({
            
            switch self {
            case .voltDC25:
                value = Double( $0.load(as: UInt16.self) ) * 0.001
            case .amp30:
                value = Double( $0.load(fromByteOffset: 2, as: Int16.self) ) * 0.001
            case .res0:
                value = Double( $0.load(fromByteOffset: 4, as: UInt16.self) )
            }
            
        })
        
        
        return value
    }
    
//    mutating func changeMode(modeIndex: Int){
//        switch modeIndex {
//        case 2:
//            self = .voltDC25
//        case 3:
//            self = .amp30
//        case 4:
//            self = .res0
//        default:
//            self = .unknown
//        }
//    }
    
//    static func getModeFromInt(modeIndex: Int) -> PeripheralMode{
//        switch modeIndex {
//        case 2:
//            return PeripheralMode.voltDC25
//        case 3:
//            return PeripheralMode.amp30
//        case 4:
//            return PeripheralMode.res0
//        }
//    }
}



