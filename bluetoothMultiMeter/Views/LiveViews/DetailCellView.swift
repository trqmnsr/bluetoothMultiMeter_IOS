//
//  DetailCellView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/23/22.
//

import SwiftUI

struct DetailCellView: View {
    
    let label: String
    var value: Double
    
    var unitValue: String
    
    private var formattedLabel: String {
        String("\(label): ")
    }
    
    private var stringValue: String {
        String(format: "%.4f \(unitValue)", value)
    }
        
    
    var body: some View {
        HStack {
            Text(formattedLabel)
                .frame(alignment: .trailing)
                .lineLimit(1)
            Text (stringValue)
                .frame( alignment: .trailing)
                .lineLimit(1)
            
        }
        
            
    }
}

struct DetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCellView(label: "Max" , value: 23.67543, unitValue: "V" )
            .previewLayout(.fixed(width: 200, height: 25))
    }
}
