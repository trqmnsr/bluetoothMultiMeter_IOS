//
//  LiveViewRow.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/4/22.
//

import SwiftUI

struct LiveViewRow: View {
    
    @StateObject var peripheral: Peripheral
    @State var isShownOnGraph = true
    
    var modeTitle: String {
        peripheral.mode.settings().title
    }
    
    var modeUnits: String {
        peripheral.mode.settings().units
    }
    
    var isValidPeripheral:  Bool  {
        if peripheral.dataSet != nil && !peripheral.dataSet.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    var max_value: Double {
        isValidPeripheral ? peripheral.dataSet.yMax : 0.0
    }
    
    var min_value: Double {
        isValidPeripheral ? peripheral.dataSet.yMin : 0.0
    }
    
    var ave_value: Double {
        if isValidPeripheral {
            let sum = peripheral.dataSet.map({$0.y}).reduce(0, +)
            return peripheral.dataSet.count > 0 ? sum / Double(peripheral.dataSet.count): 0
        } else {
            return 0.0
        }
        
    }
    
    var body: some View {
        VStack {
            Text("\(peripheral.name): \(modeTitle) in \(modeUnits)")
            HStack {
                DetailCellView(label: "CUR", value: peripheral.currentValue)
                Spacer()
                DetailCellView(label: "AVE", value: ave_value)
            }
            .frame( alignment: .leading)
            
            HStack {
                DetailCellView(label: "MAX", value: max_value)
                Spacer()
                DetailCellView(label: "MIN", value: min_value)
                
            }
            .frame( alignment: .trailing)
            
            HStack {
                ColorPicker("Color", selection: $peripheral.color, supportsOpacity: false)
                Spacer()
                Toggle("Include:", isOn: $peripheral.isIncluded)
            }
        }
        .frame( maxWidth: 400, alignment: .leading)
        .padding()
        .border(.foreground, width: 3)
    }
}


//import CoreBluetooth
//struct LiveViewRow_Previews: PreviewProvider {
//
//   static var previews: some View {
//       LiveViewRow(peripheral: Peripheral(peripheral: nil, central: BluetoothManager()))
//    }
//}
