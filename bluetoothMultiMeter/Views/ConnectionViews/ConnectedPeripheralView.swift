//
//  ConnectedPeripheralView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/26/22.
//
//  This view will appear when a Peripheral is successfully connected to manager.

import SwiftUI
import OrderedCollections


struct ConnectedPeripheralView: View {
    
    @State var tap = false
    @StateObject var peripheral: Peripheral
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(peripheral.name)
                    Spacer()
                    // Text(peripheral.id.state.toString())
                }
                Spacer()
                VStack {
                    RSSIAntena(rssiValue: $peripheral.rssiValue)
                    Spacer()
                    Button("Disconnect", action: {peripheral.disconnect()})
                }
            }.padding()
        }
    } // body
    
    
} // struct ConnectedPeripheralView
