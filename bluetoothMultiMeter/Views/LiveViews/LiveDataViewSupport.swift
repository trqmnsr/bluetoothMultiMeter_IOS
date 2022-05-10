//
//  LiveDataViewSupport.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/9/22.
//

import SwiftUI

extension LiveDataView{
    
    var isDisabledNoPeripheral: Bool {
        numberOfConnectedPeripheral < 1
    }
    
    var sortedConnectedPeripheralList: [Peripheral] {
        manager
            .connectedPeripherals
            .filter{ $0.rssiValue != RssiSignal.unusable }
            .sorted(by: {$0.name < $1.name})
    }
    
    var numberOfConnectedPeripheral: Int {
        manager.connectedPeripherals.count
    }
    
    var deviceDropdownHeader: String {
        if numberOfConnectedPeripheral > 0 {
            return "Devices (\(numberOfConnectedPeripheral))"
        } else {
            return "No Devices Connected"
        }
    }
    
    var deviceView: some View {
        //DisclosureGroup(deviceDropdownHeader, isExpanded: $devicesisExpanded) {
        ForEach(sortedConnectedPeripheralList) { peripheral in
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 400))]) {
                LiveViewRow(peripheral: peripheral)
                    .id(peripheral.id.id)
            }
        }
        //}.padding(.horizontal)
        
    }
    
    var chartView: some View {
        VStack {
            isLabelsShown ? Text("Title Hear") : nil
            
            HStack {
                isLabelsShown ? Text("Volts")
                    .rotationEffect(.degrees(-90)) : nil
                VStack {
                    linechart
                    isLabelsShown ? Text("Time (s)") : nil
                }
            }
        }
    }
    
    enum DropdownOptions: String, CaseIterable, Identifiable {
        var id: Self {self}
        
        case deviceV
        case controlsV
    }
    
    
    var dropDownPicker: some View {
        
        DisclosureGroup(deviceDropdownHeader) {
            Picker("Picker", selection: $pickViewDropdown) {
                //deviceView.tag(DropdownOptions.deviceV)
                //controlView.tag(DropdownOptions.controlsV)
                Text("Controls").tag(DropdownOptions.controlsV)
                Text("Devices").tag(DropdownOptions.deviceV)
            }
            .pickerStyle(.segmented)
            
            if pickViewDropdown.id == .controlsV {
                controlView
            } else {
                deviceView
            }
            
            
        }
    }
    
    var controlView: some View {
        //DisclosureGroup("Controls"){
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            Button(recordState.title(), action: {
                switch  recordState {
                case .standby:
                    for peripheral in sortedConnectedPeripheralList {
                        if peripheral.isIncluded{
                            
                            let dataset = linechart.startRecording(peripheral: peripheral)
                            peripheral.startRecord(dataset: dataset, updater: linechart.update)
                        }
                    }
                case .recording:
                    for peripheral in sortedConnectedPeripheralList {
                        peripheral.stopRecording()
                    }
                case .stopped:
                    linechart.reset()
                }
                recordState.click()
                
                
            })
            .buttonStyle(MyButtonStyle())
            .disabled(isDisabledNoPeripheral)
            
            Button("Share Image", action: {
                shareModal = true
            })
            .buttonStyle(MyButtonStyle())
            //.disabled(isDisabledNoPeripheral)
            .sheet(isPresented: $shareModal, content: {
                //let image = chartView.snapshot()
                ActivityViewController(activityItems: [linechart.getImage()])
            })
            
            Toggle("Labels", isOn: $isLabelsShown)
            
        }.frame( alignment: .leading)
            .frame(alignment: .topLeading)
            .padding()
        //}.padding(.horizontal)
    }
}

