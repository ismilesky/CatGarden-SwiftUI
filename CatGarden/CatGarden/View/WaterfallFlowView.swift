//
//  WaterfallFlowView.swift
//  CatGarden
//
//  Created by edy on 2023/6/19.
//

import SwiftUI

struct WaterfallFlowView<Content: View,T: Identifiable>: View where T: Hashable {
    
    // It will return each object from collection to build View...
    var content: (T) -> Content
    
    var list: [T]
    
    // Columns...
    var columns: Int
    
    // Properties...
    var showsIndicators: Bool
    var spacing: CGFloat
    
    init(columns: Int,showsIndicators: Bool = false,spacing: CGFloat = 10,list: [T],@ViewBuilder content: @escaping (T)->Content){
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.columns = columns
    }
    
    // Staggered Grid Function....
    func setUpList()->[[T]]{
        
        // creating empty sub arrays of columns count...
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        // spiliting array for Vstack oriented View....
        var currentIndex: Int = 0
        
        for object in list{
            gridArray[currentIndex].append(object)
            
            // increasing index count...
            // and resetting if overbounds the columns count...
            if currentIndex == (columns - 1){
                currentIndex = 0
            }
            else{
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
        
        HStack(alignment: .top,spacing: 20){
            
            ForEach(setUpList(),id: \.self){columnsData in
                
                // For Optimized Using LazyStack...
                LazyVStack(spacing: spacing){
                    
                    ForEach(columnsData){object in
                        content(object)
                    }
                }
                .padding(.top,getIndex(values: columnsData) == 1 ? 80 : 0)
            }
        }
        // only vertical padding...
        // horizontal padding will be user's optional...
        .padding(.vertical)
    }
    
    // Moving Second row little Down....
    func getIndex(values: [T])->Int{
        
        let index = setUpList().firstIndex { t in
            return t == values
        } ?? 0
        
        return index
    }
}

