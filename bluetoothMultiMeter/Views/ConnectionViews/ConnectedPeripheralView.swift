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
            Text(peripheral.name)
            Spacer()
            VStack {
                RSSIAntena(rssiValue: peripheral.rssiValue)
                Spacer()
                Button("Disconnect", action: {peripheral.disconnect()})
            }
        }
    } // body
    
    
} // struct ConnectedPeripheralView
