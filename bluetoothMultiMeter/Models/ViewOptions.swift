//
//  ViewOptions.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/23/22.
//

import Foundation

enum GraphViewControlOptions: String, CaseIterable, Identifiable {
    var id: Self {self}
    
    case deviceView
    case controlsView
}
