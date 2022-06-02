//
//  ConfigGraph.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 6/2/22.
//

import SwiftUI
import Charts

struct ConfigGraph: View {
    
    @Binding var isPresented: Bool
    @Binding var isLabelsShown: Bool
    @Binding var titleLabel: String
    @Binding var xLabel: String
    @Binding var yLabel: String
    @Binding var linechart: LineChartView
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    
    @State var showGrid: Bool = true

    
    var body: some View {
        VStack {
            Text("Graph Configuration")
                .fontWeight(.bold)
                .frame(alignment: .leading)
                .padding()
            Form {
                Toggle("Color Mode",isOn: $isDarkMode)
//                Toggle("Show Grid",isOn: $showGrid)
//                    .onSubmit {
//                        print("grid \(showGrid)")
//                        linechart.xAxis.drawAxisLineEnabled = showGrid
//                        linechart.xAxis.drawGridLinesEnabled = showGrid
//                        linechart.leftAxis.drawGridLinesEnabled = showGrid
//                    }
                Toggle("Show Labels", isOn: $isLabelsShown)
                if isLabelsShown {
                    Section ("Graph Labels"){
                        TextField("Title", text: $titleLabel)
                        TextField("Time Label", text: $xLabel)
                        TextField("Value Label", text: $yLabel)
                    }
                    
                }
            }
            Button("Back",action:{isPresented = false})
            
        }

    }
}

//struct ConfigGraph_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfigGraph(
//            isPresented: .constant(true),
//            isLabelsShown: .constant(false), linechart: LineChartElement())
//    }
//}


