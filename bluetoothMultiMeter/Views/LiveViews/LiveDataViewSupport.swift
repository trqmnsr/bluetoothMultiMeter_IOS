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
    
    var hasNoConnections: Bool {
        manager.connectedPeripherals.isEmpty
    }
    
    var deviceView: some View {
        
        
        ForEach(sortedConnectedPeripheralList) { peripheral in
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300, maximum: 400))]) {
                DeviceLiveCell(peripheral: peripheral)
                    .id(peripheral.id.id)
            }
        }
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
        
        DisclosureGroup(deviceDropdownHeader, isExpanded: $isDropDown) {
            Picker("Picker", selection: $pickViewDropdown) {
                Text("Controls").tag(DropdownOptions.controlsV)
                Text("Devices").tag(DropdownOptions.deviceV)
            }
            .pickerStyle(.segmented)
            
            if pickViewDropdown.id == .controlsV {
                
                    controlView

                
            } else {
                if hasNoConnections {
                    Text("Device not Connected")
                } else {
                deviceView
                }
            }
            
            
        }
    }
    
    var controlView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            Button(recordState.title(), action: {
                switch  recordState {
                case .standby:
                    for peripheral in sortedConnectedPeripheralList {
                        linechart.reset()
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
            
            Button("Share Image", action: { shareImageModal = true })
            .buttonStyle(MyButtonStyle())
            .sheet(isPresented: $shareImageModal, content: {
                let image = linechart.getImage()
                ActivityViewController(activityItems: [image])
            })
            Button("Share Data", action: {
                shareDataModal = true
            })
            .buttonStyle(MyButtonStyle())
            .sheet(isPresented: $shareDataModal, content: {
                let data: [Data] = sortedConnectedPeripheralList.map({$0.getJSONData() ?? Data()})
                
                ActivityViewController(activityItems: data)
                
            })
            
            Toggle("Labels", isOn: $isLabelsShown)
            
        }.frame( alignment: .leading)
            .frame(alignment: .topLeading)
            .padding()
    }
}

