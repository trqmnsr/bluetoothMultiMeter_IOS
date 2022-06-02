//
//  ModeModel.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/25/22.
//

import Charts
import SwiftUI

class PeripheralModeModel: ObservableObject, Identifiable {
    
    var assignedPeripheral: Peripheral!
    let assignedMode: PeripheralMode
    @Published var colour: CGColor = .getRandomColor()
    @Published var currentValue : Double = 0.0
    var dataSet: LineChartDataSet!
    
    init(mode: PeripheralMode) {
        assignedMode = mode
    }
    
    func assignDataSet(dataset: LineChartDataSet) {
        dataSet = dataset
    }
    
    
}
