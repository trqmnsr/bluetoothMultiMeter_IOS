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
    
    
    var dataEntries: [ChartDataEntry] = [ChartDataEntry(x: 0, y: 0)]
    var data: LineChartData!
    var datasets: [LineChartDataSet] = [LineChartDataSet]()

    @State var linechart: LineChartView = LineChartView()
    
    func makeUIView(context: Context) -> LineChartView {
        linechart.data = data
        linechart.rightAxis.enabled = false
        linechart.legend.enabled = false
        formatxAxis(axis: linechart.xAxis)
        formatleftAxis(axis: linechart.leftAxis)
        linechart.doubleTapToZoomEnabled = false
        linechart.highlightPerDragEnabled = false
        linechart.chartDescription.enabled = true
        linechart.pinchZoomEnabled = true
        
        return linechart
    }
    
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        update()
    }
    
    func formatDataSet(dataSet: LineChartDataSet, peripheral: Peripheral) {
        dataSet.lineWidth = CGFloat( peripheral.linewidth)
        dataSet.mode = peripheral.lineChartMode
        dataSet.drawCirclesEnabled = peripheral.showcircle
        dataSet.circleColors = [UIColor(cgColor:peripheral.circlecolor)]
        dataSet.drawCircleHoleEnabled = peripheral.showhole
        dataSet.circleHoleColor = UIColor(cgColor:peripheral.holecolor)
        dataSet.drawValuesEnabled = peripheral.showvalue
        dataSet.drawVerticalHighlightIndicatorEnabled  = true
        dataSet.highlightEnabled = false
        
        dataSet.valueFormatter = DefaultValueFormatter(decimals: 3)
        dataSet.valueFont = NSUIFont.systemFont(ofSize: 20)
        
    }
    
    func formatxAxis(axis: XAxis) {
        axis.axisLineWidth = 2
        axis.labelFont = .systemFont(ofSize: 14)
        axis.labelPosition = .bottom
        axis.accessibilityScroll(.right)
    }
    
    func formatleftAxis(axis: YAxis) {
        axis.axisLineWidth = 2
        axis.labelFont = .systemFont(ofSize: 14)
        axis.axisMinLabels = 0
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
    
    
    func reset() {
        if let data = data {
            data.dataSets.removeAll(keepingCapacity: false)
        }
        
    }
    
    func isEmpty() -> Bool {
        return data == nil || data.isEmpty
    }
    
    mutating func startRecording(peripheral: Peripheral) -> LineChartDataSet {
        data = LineChartData()
        let newDataSet = LineChartDataSet(label: peripheral.name)
        data.append(newDataSet)
        linechart.data = data
        formatDataSet(dataSet: newDataSet, peripheral: peripheral)
        newDataSet.colors = [UIColor(cgColor: peripheral.color)]
        return newDataSet
    }
    
    
    func update(){
        if let data = data {
            if data.count > 0{
                data.notifyDataChanged()
                linechart.notifyDataSetChanged()
            }
        }
        
    }
    
    
    
    
}

struct TransactionLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartElement()
    }
}

//
//extension Highlighter {
//
//
//    func getHighlight(x: CGFloat, y: CGFloat) -> Highlight? {
//        print("x Value: \(x)\ny Value: \(y)")
//        let h = Highlight(x: x, y: y, dataSetIndex: 1)
//        return h
//    }
//
//}


class MyHighlighter: Highlighter {
    
    func getHighlight(x: CGFloat, y: CGFloat) -> Highlight? {
        print("x Value: \(x)\ny Value: \(y)")
        let h = Highlight(x: x, y: y, dataSetIndex: 0)
        return h
    }
    
    
}
