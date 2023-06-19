//
//  PieChartView.swift
//  CatGarden
//
//  Created by edy on 2023/6/14.
//

import SwiftUI

struct PieChartView: View {
    let records: [CatRecord]
    
    private var foodCount: Int {
        records.filter { $0.fedFood }.count
    }
    
    private var waterCount: Int {
        records.filter { $0.fedWater }.count
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .frame(width: 200, height: 200)
                
                if records.isEmpty {
                    EmptyView()
                } else {
                    PieSlice(startAngle: angle(for: 0), endAngle: angle(for: foodCount)).foregroundColor(.blue)
                    PieSlice(startAngle: angle(for: foodCount), endAngle: angle(for: foodCount + waterCount)).foregroundColor(.green)
                }
            }
            
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 20, height: 20)
                Text("Food")
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                Text("Water")
            }
        }
    }
    
    private func angle(for count: Int) -> Angle {
        let total = records.count
        let fraction = total > 0 ? Double(count) / Double(total) : 0
        return Angle(degrees: 360 * fraction)
    }
}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        path.move(to: center)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.closeSubpath()

        return path
    }
}
