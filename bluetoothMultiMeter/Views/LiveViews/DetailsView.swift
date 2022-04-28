//
//  DetailsView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/23/22.
//

import SwiftUI
import Charts

struct DetailsView: View {
    
    @EnvironmentObject var dataSource: DataSourceGenerator
    
    var max_value: Double {
        dataSource.dataPoints.map({$0.y}).max() ?? 0
    }
    
    var min_value: Double {
        dataSource.dataPoints.map({$0.y}).min() ?? 0
    }
    
    var ave_value: Double {
        let sum = dataSource.dataPoints.map({$0.y}).reduce(0, +)
        return dataSource.dataPoints.count > 0 ? sum / Double(dataSource.dataPoints.count): 0
    }

    
    var body: some View {
        VStack {
            HStack {
                DetailCellView(label: "MAX", value: max_value, unitValue: "V")
                
                DetailCellView(label: "AVE", value: ave_value, unitValue: "V")
            }
            HStack {
                DetailCellView(label: "MIN", value: min_value, unitValue: "V")
                DetailCellView(label: "NONE", value: 0, unitValue: "V")
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
            .environmentObject(DataSourceGenerator())
        .previewLayout(.fixed(width: 600, height: 70))
    }
}
