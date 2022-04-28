//
//  RssiStrength.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/24/22.
//

import Foundation
import SwiftUI


enum RssiSignal {
    
    case amazing
    case verygood
    case okay
    case notGood
    case unusable
    
    func description() -> String {
        switch self {
        case .amazing:
            return "Amazing"
        case .verygood:
            return "Very Good"
        case .okay:
            return "Okay"
        case .notGood:
            return "Not Good"
        case .unusable:
            return "Unusable"
        }
    }
    
    static func getSignalFor(value: NSNumber) -> RssiSignal {
        switch value as! Int {
        case -67 ... 0:
            return .amazing
        case -70 ..< -67:
            return .verygood
        case -80 ..< -70:
            return .okay
        case -90 ..< -80:
            return .notGood
        default:
            return .unusable
        }
    }
    
    func getColor() -> Color {
        switch self {
        case .amazing:
            return .green
        case .verygood:
            return .yellow
        case .okay:
            return .orange
        case .notGood:
            return .red
        case .unusable:
            return .clear
        }
    }
    
    
}
