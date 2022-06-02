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
    
    var isDisableWhileRecording: Bool {
        recordState == .recording
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
    
    var hasNoConnections: Bool {
        manager.connectedPeripherals.isEmpty
    }
    
    var deviceDropdownHeader: String {
        if numberOfConnectedPeripheral > 0 {
            return "Devices (\(numberOfConnectedPeripheral))"
        } else {
            return "No Devices Connected"
        }
    }
    
    
    var chartView: some View {
        VStack {
            isLabelsShown ? Text(chartTitle) : nil
            
            HStack {
                isLabelsShown ? Text(chartYLable)
                    .rotationEffect(.degrees(-90)) : nil
                VStack {
                    linechart
                    isLabelsShown ? Text(chartXLable) : nil
                }
            }
        }
    }
    
    
    var dropDownPicker: some View {
        
        DisclosureGroup(deviceDropdownHeader, isExpanded: $isDropDown) {
            Picker("Picker", selection: $pickViewDropdown) {
                Text("Controls").tag(GraphViewControlOptions.controlsView)
                Text("Devices").tag(GraphViewControlOptions.deviceView)
            }
            .pickerStyle(.segmented)
            
            if pickViewDropdown.id == .controlsView {
                controlView
            } else {
                if hasNoConnections {
                    Text("Device not Connected")
                        .onTapGesture(perform: {
                            tabSelection = Tabs.scanner.rawValue
                        })
                } else {
                    deviceView
                }
            }
        }
    }
    
    
    var controlView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 370))]) {
            Button(recordState.title(),
                   action: {
                switch  recordState {
                case .standby:
                    for peripheral in sortedConnectedPeripheralList {
                        linechart.reset()
                        let dataset = linechart.startRecording(peripheral: peripheral)
                        if peripheral.isIncluded{
                            
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
                .disabled(isDisabledNoPeripheral || isDisableWhileRecording  || linechart.isEmpty())
                .buttonStyle(MyButtonStyle())
                .sheet(isPresented: $shareImageModal, content: {
                    let image = linechart.getImage()
                    ActivityViewController(activityItems: [image])
                })
            Button("Share Data", action: {
                shareDataModal = true
            })
            .disabled(isDisabledNoPeripheral || isDisableWhileRecording  || linechart.isEmpty())
            .buttonStyle(MyButtonStyle())
            .sheet(isPresented: $shareDataModal, content: {
                let data: [Data] = sortedConnectedPeripheralList.map({$0.getJSONData() ?? Data()})
                ActivityViewController(activityItems: data)
                
            })
            Spacer()
            //
            Button("Graph Settings") { showConfig.toggle() }
                .sheet(isPresented: $showConfig)  {
                    ConfigGraph(
                        isPresented: $showConfig,
                        isLabelsShown: $isLabelsShown,
                        titleLabel: $chartTitle,
                        xLabel: $chartXLable,
                        yLabel: $chartYLable,
                        linechart: linechart.$linechart
                    )
                    
                }
            
            
        }
        .frame( alignment: .center)
        .padding()
    }
    
    var deviceView: some View {
        
        HStack {
            ForEach(sortedConnectedPeripheralList) { peripheral in
                DeviceLiveCell(peripheral: peripheral, currentState: $recordState)
                    
            }
        }
    }
}

