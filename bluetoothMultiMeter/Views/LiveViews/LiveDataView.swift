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
    
    @Binding var tabSelection: Int
    
    @State var devicesisExpanded = true
    
    @State var linechart = LineChartElement()
    
    @State var recordState: RecordingState = .standby
    
    @State var isDropDown = true
    
    @State var shareImageModal = false
    
    @State var shareDataModal = false
    
    @State var isLabelsShown = false
    
    @State var pickViewDropdown: GraphViewControlOptions = .controlsView
    
    @State var chartTitle: String = "Title here!"
    
    @State var chartXLable: String = "Time (s)"
    
    @State var chartYLable: String = "Value"
    
    @State var showConfig: Bool = false
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    
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
        LiveDataView(tabSelection: .constant(0))
            .environmentObject(BluetoothManager())
            .previewInterfaceOrientation(.portrait)
    }
    
}
