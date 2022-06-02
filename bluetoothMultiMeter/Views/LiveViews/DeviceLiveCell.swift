//
//  LiveViewRow.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/4/22.
//

import SwiftUI

struct DeviceLiveCell: View {
    
    @StateObject var peripheral: Peripheral
    @State var isShownOnGraph = true
    @Binding var currentState: RecordingState
    @State var showConfig: Bool = false
    
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
    
    var isDisableWhileRecoring: Bool {
        currentState == .recording
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
            HStack {
                Text("\(peripheral.name)")
                Spacer()
                Text("Mode Select:")
                Picker("Mode", selection: $peripheral.mode) {
                    ForEach (PeripheralMode.allCases, content: { mode in
                        Text( mode.settings().title )
                            .tag(mode)
                    })
                    
                }.disabled(isDisableWhileRecoring)
            }
            HStack {
                DetailCellView(label: "", value: peripheral.currentValue)
                    .frame( alignment: .trailing)
                    .font(.custom("Big", fixedSize: 40.0))
                Spacer()
                Text(peripheral.mode.settings().units)
            }
            HStack {
                DetailCellView(label: "MAX:", value: max_value)
                Spacer()
                DetailCellView(label: "AVE:", value: ave_value)
                Spacer()
                DetailCellView(label: "MIN:", value: min_value)
            }
            .frame( alignment: .center)
            
            HStack {
                Button("Graph Config") { showConfig.toggle() }
                    .sheet(isPresented: $showConfig)  {ConfigDevice(peripheral: peripheral, isPresented: $showConfig)}
                
            }
        }
        .frame( maxWidth: 370, alignment: .leading)
        .padding()
        .border(.foreground, width: 3)
    }
}


//import CoreBluetooth
//struct LiveViewRow_Previews: PreviewProvider {
//    
//    var peripheral: Peripheral {
//        let peripheral = Peripheral(peripheral: CBPeripheral(), central: BluetoothManager())
//        peripheral.mode = .voltDC25
//        return peripheral
//    }
//
//   static var previews: some View {
//       LiveViewRow(peripheral: Peripheral(peripheral: peripheral, central: BluetoothManager()))
//    }
//}
