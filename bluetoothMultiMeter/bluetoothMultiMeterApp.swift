//
//  bluetoothMultiMeterApp.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/14/22.
//

import SwiftUI

@main
struct bluetoothMultiMeterApp: App {
    @StateObject var dataSource = StaticDataSource()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataSource)
        }
    }
}
