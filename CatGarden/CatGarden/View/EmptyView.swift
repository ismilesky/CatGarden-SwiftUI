//
//  EmptyView.swift
//  CatGarden
//
//  Created by edy on 2023/6/19.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Image("NotFound")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .padding(.top,35)
            
            Text("暂无数据")
                .font(.custom("Helvetica", size: 25))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .padding(.bottom,100)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
