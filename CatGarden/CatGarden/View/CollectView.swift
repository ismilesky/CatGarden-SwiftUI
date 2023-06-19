//
//  collectView.swift
//  CatGarden
//
//  Created by edy on 2023/6/19.
//

import SwiftUI

struct CollectView: View {
   
    @EnvironmentObject var sharedData: ShareDataModel
    
    @State var showDeleteOption: Bool = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    TopNavView(showDeleteOption: $showDeleteOption).environmentObject(sharedData)
        
                    if sharedData.collecCats.isEmpty{
                        EmptyView()
                    }
                    else{
                        VStack(spacing: 15){
                            // For Designing...
                            ForEach(sharedData.collecCats) {cat in
                                HStack(spacing: 0){
                                    if showDeleteOption{
                                        Button {
                                            deleteCat(cat: cat)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    CollectCardView(cat:cat)
                                }
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("Bg")
                    .ignoresSafeArea()
            )
        }
    }
    
    func deleteCat(cat: Cat) {
        if let index = sharedData.collecCats.firstIndex(where: { currentCat in
            return cat.id == currentCat.id
        }){
             withAnimation{
                 sharedData.deleteCat(index)
            }
        }
    }
}

struct TopNavView: View {
    @Binding var showDeleteOption: Bool
    @EnvironmentObject var sharedData: ShareDataModel

    var body: some View {
        HStack{
            Text("收藏馆")
                .font(.custom("PlayfairDisplay-Regular", size: 28).bold())
            
            Spacer()
            
            Button {
                withAnimation{
                    showDeleteOption.toggle()
                }
            } label: {
                Image(systemName: "trash")
                    .font(.title2)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
            .opacity(sharedData.collecCats.isEmpty ? 0 : 1)
        }
    }
}



struct CollectCardView: View {
    var cat: Cat
    
    var body: some View {
        HStack(spacing: 15){
            
            Image(cat.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(cat.name)
                    .font(.custom("Helvetica", size: 18).bold())
                    .lineLimit(1)
                
                Text("原产地: \(cat.origin)")
                    .font(.custom("Helvetica", size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple1"))
                
                Text("毛长: \(cat.hairType)")
                    .font(.custom("Helvetica", size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
        
            Color.white
                .cornerRadius(10)
        )
    }
}


//struct CollectView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectView().environmentObject(HomeViewModel())
//    }
//}
