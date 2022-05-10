//
//  RecordingState.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/7/22.
//

import Foundation

enum RecordingState {
    
    case standby
    case recording
    case stopped
    
    mutating func click() {
        switch self {
        case .standby:
            self = .recording
        case .recording:
            //self = .stopped
            self = .standby
        case .stopped:
            self = .standby
        }
    }
    
    func title() -> String {
        switch self {
            
        case .standby:
            return "Record"
        case .recording:
            return "Pause"
        case .stopped:
            return "Reset"
        }
    }
} // End enum RecordingState
