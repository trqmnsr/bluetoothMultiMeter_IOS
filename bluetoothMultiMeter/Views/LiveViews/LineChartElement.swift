//
//  LineChartView.swift
//  btMultimeter
//
//  Created by Tareq Mansour on 4/14/22.
//
//
import SwiftUI
import Charts

final class LineChartElement: UIViewRepresentable {
    
    var dataEntries: [ChartDataEntry] = [ChartDataEntry(x: 0, y: 0), ChartDataEntry(x: 10, y: 0)]
    var data: LineChartData = LineChartData()
    var datasets: [LineChartDataSet] = [LineChartDataSet]()

    @State private var linechart: LineChartView = LineChartView()
    
    init() {
        data.append(hiddenDataSet())
        linechart.data = data
    }
    
    
    func makeUIView(context: Context) -> LineChartView {
        //linechart.highlighter = AHighlighter()
        linechart.rightAxis.enabled = false
        linechart.legend.enabled = false
        linechart.accessibilityScroll(.right)
        formatxAxis(axis: linechart.xAxis)
        formatleftAxis(axis: linechart.leftAxis)
        
        
        return linechart
    }
    
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        update()
        print("update")
    }
    
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = true
        dataSet.drawValuesEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled  = true
        dataSet.highlightEnabled = true
        //dataSet.setDrawHighlightIndicators(true)
        dataSet.highlightColor = .purple
        
    }
    
    func formatxAxis(axis: XAxis) {
        axis.axisLineWidth = 2
        axis.labelFont = .systemFont(ofSize: 14)
        axis.labelPosition = .bottom
        axis.accessibilityScroll(.right)
        
        //axis.axisRange = 10
        //axis.axisMinimum = 0
    }
    
    func formatleftAxis(axis: YAxis) {
        axis.axisLineWidth = 2
        axis.labelFont = .systemFont(ofSize: 14)
        axis.axisMinLabels = 0
        //axis.axisMinimum = 0
    }
    
    
    func hiddenDataSet() ->  LineChartDataSet {
        let dataSet = LineChartDataSet([ChartDataEntry(x: 0, y: 0), ChartDataEntry(x: 10, y: 0)])
        dataSet.colors = [.systemBackground]
        dataSet.drawCirclesEnabled = false
        dataSet.drawCircleHoleEnabled = true
        dataSet.lineWidth = 0
        return dataSet
    }
    
    
    
    func getImage() -> UIImage {
        let image = linechart.getChartImage(transparent: false)!
        return image
    }
    
    func saveImageToPhotoAlbum() {
        UIImageWriteToSavedPhotosAlbum(getImage(), nil, nil, nil)
    }
    
    
    
    
    func startRecording(peripheral: Peripheral) -> LineChartDataSet {
        data.dataSets.removeAll(keepingCapacity: false)
        //data.dataSets.removeFirst()
        let newDataSet = LineChartDataSet(label: peripheral.name)
        data.append(newDataSet)
        formatDataSet(dataSet: newDataSet)
        newDataSet.colors = [UIColor(cgColor: peripheral.color)]
        return newDataSet
    }
    
    func reset() {
        
    }
    
    func update(){
        if data.count > 0{
            data.notifyDataChanged()
            linechart.notifyDataSetChanged()
                
        }
    }
    
    
    
}

struct TransactionLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartElement()
    }
}


extension Highlighter {
    
    
    func getHighlight(x: CGFloat, y: CGFloat) -> Highlight? {
        print("x Value: \(x)\ny Value: \(y)")
        let h = Highlight(x: x, y: y, dataSetIndex: 1)
        return h
    }
    
}
