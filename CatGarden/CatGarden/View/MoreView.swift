//
//  MoreView.swift
//  CatGarden
//
//  Created by edy on 2023/6/19.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        VStack{
            Text("More Info")
                .font(.custom("PlayfairDisplay-Regular", size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            WebView(url: URL(string: "https://www.baidu.com")!)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
