//
//  NavigationView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/19/22.
//

import SwiftUI



struct NavigationView: View {
    
    @StateObject var manager = BluetoothManager()
    @State var selection: Int = Tabs.liveView.rawValue
    
    var body: some View {
        TabView(selection: $selection) {
            
            LiveDataView(tabSelection: $selection)
                .environmentObject(manager)
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(.mint, .gray)
                        .font(.system(size: 42.0))
                    Text("live Data")
                }.tag(Tabs.liveView.rawValue)
            
            
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
                .tag(Tabs.scanner.rawValue)
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
