//
//  CatRecordView.swift
//  CatGarden
//
//  Created by edy on 2023/6/14.
//

import SwiftUI

struct CatRecordView: View {
    @State private var records: [CatRecord] = []
    @State private var showStatistics = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(records) { record in
                    VStack(alignment: .leading) {
                        Text(dateString(record.date))
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: record.fedFood ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(record.fedFood ? .green : .red)
                            Text("Food")
                            
                            Image(systemName: record.fedWater ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(record.fedWater ? .green : .red)
                            Text("Water")
                        }
                    }
                }
                
                HStack {
                    Button(action: {
                        let record = CatRecord(date: Date(), fedFood: true, fedWater: false)
                        records.append(record)
                    }) {
                        Text("Feed Food")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        let record = CatRecord(date: Date(), fedFood: false, fedWater: true)
                        records.append(record)
                    }) {
                        Text("Feed Water")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Button(action: {
                    showStatistics = true
                }) {
                    Text("View Statistics")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Cat Feeding Tracker")
        }
        .sheet(isPresented: $showStatistics) {
            StatisticsView(records: records)
        }
    }
    
    private func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}


struct CatRecordView_Previews: PreviewProvider {
    static var previews: some View {
        CatRecordView()
    }
}
