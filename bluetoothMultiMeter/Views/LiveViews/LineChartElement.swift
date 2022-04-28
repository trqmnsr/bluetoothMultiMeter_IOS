//
//  LineChartView.swift
//  btMultimeter
//
//  Created by Tareq Mansour on 4/14/22.
//
//
import SwiftUI
import Charts

struct LineChartElement: UIViewRepresentable {
    
    @EnvironmentObject var dataSource: DataSourceGenerator
    
    
    private var uiView = LineChartView()

    
    func makeUIView(context: Context) -> LineChartView {

        //let uiView = LineChartView()
        //let dataSet = LineChartDataSet(entries: entries)
        uiView.data = LineChartData(dataSet: dataSource.dataPoints)
        //uiView.backgroundColor = .clear
        //uiView.highlighter = AHighlighter()
        //uiView.highlightPerTapEnabled = true
        
        formatDataSet(dataSet: dataSource.dataPoints)
        uiView.rightAxis.enabled = false
        uiView.legend.enabled = false
        uiView.accessibilityScroll(.right)
        uiView.setVisibleXRangeMaximum(10)
        formatxAxis(axis: uiView.xAxis)
        formatleftAxis(axis: uiView.leftAxis)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {uiView.notifyDataSetChanged()
            uiView.moveViewToX(10)})
        
        return uiView
    }
    
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        //let x = uiView.highlighted
        //print(x)
        uiView.notifyDataSetChanged()
        uiView.moveViewToX(10)
    }
    
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.colors = [.systemBlue]
        dataSet.drawValuesEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled  = true
        dataSet.highlightEnabled = true
        //dataSet.setDrawHighlightIndicators(true)
        dataSet.highlightColor = .cyan
    }
    
    func formatxAxis(axis: XAxis) {
        axis.axisLineWidth = 2
        axis.labelFont = .systemFont(ofSize: 14)
        axis.labelPosition = .bottom
        axis.accessibilityScroll(.right)
        axis.axisRange = 5
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
        LineChartElement()
            .environmentObject(DataSourceGenerator())
    }
}


class AHighlighter: Highlighter {
    
    
    func getHighlight(x: CGFloat, y: CGFloat) -> Highlight? {
        print("x Value: \(x)\ny Value: \(y)")
        let h = Highlight(x: x, y: y, dataSetIndex: 1)
        return h
    }
    
    
}
