//
//  NavigationView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/19/22.
//

import SwiftUI

struct NavigationView: View {
    
    
    @StateObject var manager = BluetoothManager(data: DataSourceGenerator())
    
    var body: some View {
        TabView() {
            ChartLayout()
                .environmentObject(manager.dataManager)
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(.mint, .gray)
                        .font(.system(size: 42.0))
                    Text("Chart")
                }.tag(1)
            Text("Data").tabItem {
                Image(systemName: "archivebox.fill")
                Text("Data")
            }
            .tag(2)
            
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
