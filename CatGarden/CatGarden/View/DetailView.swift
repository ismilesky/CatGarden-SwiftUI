//
//  DetailView.swift
//  CatGarden
//
//  Created by edy on 2023/6/18.
//

import SwiftUI

struct DetailView: View {
    var cat: Cat
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: ShareDataModel
    
    var body: some View {
        NavigationView {
            
            VStack {
                VStack {
                    HStack{
                        Button {
                            withAnimation(.easeInOut){
                                sharedData.showDetailCat = false
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(Color.black.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Button {
                            addToCollect()
                        } label: {
                            Image(systemName:"star.fill")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                        }
                    }
                    .padding()
                    
                    Image(cat.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(cat.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                        .padding(.horizontal)
                        .offset(y: -12)
                        .frame(maxHeight: .infinity)
                }
                .frame(height: getRect().height / 2.7)
                .zIndex(1)
                DescInfoView(cat: cat)
            }
            .background(
                Color("Bg").ignoresSafeArea()
            )
        }
        
    }
    
    func addToCollect(){
        sharedData.addToCollect(cat)
    }
    
    func isLiked()->Bool{
        return sharedData.collecCats.contains { cat in
            return self.cat.id == cat.id
        }
    }
}

struct TopView: View {
    var cat: Cat
    var animation: Namespace.ID
    @EnvironmentObject var sharedData: ShareDataModel
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    withAnimation(.easeInOut){
                        sharedData.showDetailCat = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                Spacer()
                
                Button {
                } label: {
                    Image(systemName:"star.fill")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundColor( Color.black.opacity(0.7))
                }
            }
            .padding()
            
            Image(cat.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "\(cat.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                .padding(.horizontal)
                .offset(y: -12)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        .frame(height: getRect().height / 2.7)
        .zIndex(1)
    }
}

struct DescInfoView: View {
    var cat: Cat
    
    var body: some View {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(cat.name)
                        .font(.custom("PlayfairDisplay-Regular", size: 20).bold())
                    getInfo(tip: "原产地: ", title: cat.origin)
                    getInfo(tip: "体型: ", title: cat.bodyType)
                    getInfo(tip: "体重: ", title: cat.weight)
                    getInfo(tip: "毛长: ", title: cat.hairType)
                    
                    Text("简介: ")
                        .font(.custom("PlayfairDisplay-Regular", size: 16).bold())
                        .padding(.top)
                    
                    Text(cat.description)
                        .font(.custom("PlayfairDisplay-Regular", size: 16))
                        .foregroundColor(.gray)
                        .lineSpacing(8.0)
                    
                    NavigationLink(destination: MoreView()) {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("更多")
                        }
                        .font(.custom("PlayfairDisplay-Regular", size: 15).bold())
                        .foregroundColor(Color("Purple1"))
                    }
                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
            )
            .cornerRadius(25, corners: [.topLeft,.topRight])
            .ignoresSafeArea()
            .zIndex(0)
        
}

fileprivate func getInfo(tip: String, title: String) -> Text {
    return Text(tip) .font(.custom("Helvetica", size: 18))
        .foregroundColor(.gray)
    + Text(title)
        .font(.custom("Helvetica", size: 18))
        .foregroundColor(.gray)
}
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
