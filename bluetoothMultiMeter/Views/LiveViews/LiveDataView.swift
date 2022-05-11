//
//  LiveDataView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/3/22.
//

import SwiftUI
import Charts

struct LiveDataView: View {
    
    @EnvironmentObject var manager: BluetoothManager
    
    @State var devicesisExpanded = true
    
    @State var linechart = LineChartElement()
    
    @State var datasets = [LineChartDataSet]()
    
    @State var mode: PeripheralMode = .unknown
    
    @State var recordState: RecordingState = .standby
    
    @State var isDropDown = true
    
    @State var shareImageModal = false
    
    @State var shareDataModal = false
    
    @State var isLabelsShown = false
    
    @State var pickViewDropdown: DropdownOptions = .controlsV
    
    
    var body: some View {
        
        VStack {
            
            dropDownPicker
                .padding()
            
            Divider()
                .foregroundColor(.blue)
            
            chartView
            
        }
    }

}



struct LiveDataView_Previews: PreviewProvider {
    static var previews: some View {
        LiveDataView()
            .environmentObject(BluetoothManager())
            .previewInterfaceOrientation(.portrait)
    }
    
}
