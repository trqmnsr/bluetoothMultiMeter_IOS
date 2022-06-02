//
//  ConfigDevice.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/29/22.
//

import SwiftUI
import Charts

struct ConfigDevice: View {
    
    
    @StateObject var peripheral: Peripheral
    @Binding var isPresented: Bool
    
    
    
    var body: some View {
        VStack {
            Text("\(peripheral.name) Graph Configuration")
                .fontWeight(.bold)
                .frame(alignment: .leading)
                .padding()
            Form {
                
                
                // MARK: Line Section
                Section ("Line") {
                    Stepper {
                        Text("Line width: \(peripheral.linewidth)")
                             } onIncrement: {
                            peripheral.linewidth += 1
                        } onDecrement: {
                            peripheral.linewidth -= 1
                        }

                    
                    
                    Picker(selection: $peripheral.lineChartMode, label: Text("Mode")) {
                        Text("Linear").tag(LineChartDataSet.Mode.linear)
                        Text("Cubic Bezier").tag(LineChartDataSet.Mode.cubicBezier)
                        Text("Horizontal Bezier").tag(LineChartDataSet.Mode.horizontalBezier)
                        Text("Stepper").tag(LineChartDataSet.Mode.stepped)
                    }.pickerStyle(.menu)
                    
                    ColorPicker("Color", selection: $peripheral.color, supportsOpacity: false)
                    
                }
                
                // MARK: Value Section
                Section ("Values"){
                    Toggle("Show Value", isOn: $peripheral.showvalue)
                    Toggle("Show Circle", isOn: $peripheral.showcircle)
                    if peripheral.showcircle {
                        ColorPicker("Circle Color", selection: $peripheral.circlecolor, supportsOpacity: true)
                        Toggle("Show Hole", isOn: $peripheral.showhole)
                        if peripheral.showhole {
                            ColorPicker("Hole Color", selection: $peripheral.holecolor, supportsOpacity: true)
                        }
                    }
                    
                    
                }
            }.navigationTitle("Device Config")
            Button("Back",action:{isPresented = false})
        }
    }
}

//struct ConfigDevice_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfigDevice()
//    }
//}
