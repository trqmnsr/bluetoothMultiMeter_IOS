//
//  PeripheralRow.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/24/22.
//

import SwiftUI
import CoreBluetooth



struct PeripheralRow: View {
    
    
    @State var tap = false
    
    @StateObject var peripheral: Peripheral
    
    
    var body: some View {
        HStack {
            Text(peripheral.name)
            Spacer()
            RSSIAntena(rssiValue: $peripheral.rssiValue)
        }
            .onTapGesture {
                tap = true
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {tap = false})
                print("Peripheral: \(peripheral.name), with id \(peripheral.id) was just clicked")
                peripheral.connect()
            }
            .scaleEffect(tap ? 0.9 : 1)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: tap)
            .background(tap ? .blue : .clear)
    } // body
    
    
} // struct PeripheralRow
