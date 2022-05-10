//
//  Scanner.swift
//  BluetoothLearn
//
//  Created by Tareq Mansour on 4/19/22.
//

import SwiftUI
import CoreBluetooth

struct ScannerView: View {
    
    @EnvironmentObject var manager: BluetoothManager
    
    
    var sortedConnectedPeripherals: [Peripheral] {
        manager
            .connectedPeripherals
            .sorted(by: {$0.name < $1.name})
    }
    
    var sortedAvailablePeripheralList: [Peripheral] {
        manager
            .peripherals
            .map {$0.value}
            //.filter {!central.connectedPeripheral.contains($0)}
            //.filter{ $0.rssiValue != RssiSignal.unusable }
            .sorted(by: {$0.name < $1.name})
        }
    
    var body: some View {
        VStack {
            HStack {
                Text("Connection Status:")
                Spacer()
                Text(manager.stateString)
            }.padding()
            
            
            List {
                Section ("Connected Devices") {
                    ForEach (sortedConnectedPeripherals) { peripheral in
                        ConnectedPeripheralView(peripheral: peripheral).frame(height: 100.0)
                    }
                }
                
                Section ("Available Devices", content: {
                    ForEach (sortedAvailablePeripheralList) { peripheral in
                        PeripheralRow(peripheral: peripheral).frame(height: 50.0)
                    }
                })
                
            } // list
        } // Vstack
    } // body
        
} // struct ScannerView

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
            .environmentObject(BluetoothManager())
    }
}

extension CBPeripheral: Identifiable {
    
    public var id: UUID {
        self.identifier
    }
}
