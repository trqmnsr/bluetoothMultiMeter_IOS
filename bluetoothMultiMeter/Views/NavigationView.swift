//
//  NavigationView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/19/22.
//

import SwiftUI

struct NavigationView: View {
    
    @StateObject var manager = BluetoothManager()
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            
            LiveDataView()
                .environmentObject(manager)
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(.mint, .gray)
                        .font(.system(size: 42.0))
                    Text("live Data")
                }.tag(0)
            
            
//            Text("Data")
//                .tabItem {
//                    Image(systemName: "archivebox.fill")
//                    Text("Data")
//                }.tag(2)
            
            ScannerView()
                .environmentObject(manager)
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Text("Device Connection")
                }
                .onAppear {
                    manager.scan()
                }
                .onDisappear {
                    manager.stopScan()
                }
                .tag(3)
        }
    }
    
    
    
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
