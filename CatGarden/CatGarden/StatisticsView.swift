//
//  StatisticsView.swift
//  CatGarden
//
//  Created by edy on 2023/6/14.
//

import SwiftUI

struct StatisticsView: View {
    let records: [CatRecord]
    
    var body: some View {
        VStack {
            Text("Statistics")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            if records.isEmpty {
                Text("No records available.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                PieChartView(records: records)
                    .aspectRatio(1, contentMode: .fit)
                    .padding()
            }
            
            Spacer()
            
            Button(action: {
                // 关闭统计图表界面
                dismiss()
            }) {
                Text("Close")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private func dismiss() {
        // 关闭统计图表界面的逻辑
    }
}
