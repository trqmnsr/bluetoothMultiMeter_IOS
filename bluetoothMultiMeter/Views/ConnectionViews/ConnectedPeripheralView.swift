//
//  ConnectedPeripheralView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/26/22.
//

import SwiftUI
import CoreBluetooth

struct ConnectedPeripheralView: View {
    
    @State var tap = false
    
    var peripheral: Peripheral
    
    var body: some View {
        HStack {
            VStack {
                Text(peripheral.name)
                Spacer()
                Text(peripheral.id.state.toString())
            }
            Spacer()
            VStack {
                RSSIAntena(rssiValue: peripheral.rssiValue)
                Spacer()
                Button("Disconnect", action: {peripheral.disconnect()})
            }
        }.padding()
    } // body
    
    
} // struct ConnectedPeripheralView
