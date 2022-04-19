//
//  LineChartView.swift
//  btMultimeter
//
//  Created by Tareq Mansour on 4/14/22.
//

import SwiftUI
import Charts

struct TransactionLineChartView: UIViewRepresentable {
    
    @EnvironmentObject var dataSource: StaticDataSource
    
    var entries: [ChartDataEntry] {
        dataSource.dataPoints
    }
    
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entries)
        formatDataSet(dataSet: dataSet)
        uiView.data = LineChartData(dataSet: dataSet)
        uiView.backgroundColor = .white
        uiView.rightAxis.enabled = false
        uiView.legend.enabled = false
        uiView.accessibilityScroll(.right)
        uiView.setVisibleXRangeMaximum(10)
        formatxAxis(axis: uiView.xAxis)
        formatleftAxis(axis: uiView.leftAxis)
        
    }
    
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.colors = [.systemBlue]
        dataSet.drawValuesEnabled = false
        dataSet.highlightEnabled = true
        dataSet.highlightLineWidth = 2
        dataSet.highlightColor = .green
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
    }
    
    func formatxAxis(axis: XAxis) {
        axis.axisLineWidth = 2
        axis.labelFont = .systemFont(ofSize: 14)
        axis.labelPosition = .bottom
        axis.accessibilityScroll(.right)
        axis.axisMinimum = 0
    }
    
    func formatleftAxis(axis: YAxis) {
        axis.axisLineWidth = 2
        axis.labelFont = .systemFont(ofSize: 14)
        axis.axisMinLabels = 0
        axis.axisMinimum = 0
    }
    
}

struct TransactionLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionLineChartView()
            .environmentObject(StaticDataSource())
    }
}
