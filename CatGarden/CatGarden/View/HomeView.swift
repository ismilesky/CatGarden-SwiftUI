//
//  HomeView.swift
//  CatGarden
//
//  Created by edy on 2023/6/16.
//

import SwiftUI

struct HomeView: View {
    var animation: Namespace.ID

    @EnvironmentObject var sharedData: ShareDataModel
//    @EnvironmentObject var homeData: HomeViewModel
    @StateObject var homeData: HomeViewModel = HomeViewModel()

    @State private var showingMoreSheet = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15) {
                // 搜索
                VStack {
                    if sharedData.searchActivated{
                        SearchBar()
                    }
                    else{
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal,25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        sharedData.searchActivated = true
                    }
                }
                
                // 主标题
                HeadTextView()
                // 分类
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20){
                        ForEach(HairType.allCases,id: \.self) { type in
                            TypeView(type: type)
                        }
                    }
                    .padding(.horizontal,30)
                }
                .padding(.top,28)
                .onChange(of: homeData.hairType) { newValue in
                    homeData.filterCatsByType()
                }
                // 内容
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25){
                        ForEach(homeData.filteredCats){cat in
                            CardView(cat: cat)
                        }
                    }
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top,80)
                }
                .padding(.top,30)
                
                // 更多
                Button {
                    showingMoreSheet = true
                } label: {                    
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("更多")
                    }
                    .font(.custom("PlayfairDisplay-Regular", size: 15).bold())
                    .foregroundColor(Color("Purple1"))
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
                .padding(.top,10)
            }
            .padding(.vertical)
        }
        .background(
            Color("Bg")
        )
        .sheet(isPresented: $showingMoreSheet) {
            MoreView()
        }
        .overlay(
            ZStack{
                if sharedData.searchActivated{
                    SearchCatView(animation: animation).environmentObject(homeData)
                }
            }
        )
    }
    
    /// 分类
    @ViewBuilder
    func TypeView(type: HairType)->some View{
        Button {
            // Updating Current Type...
            withAnimation{
                homeData.hairType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(homeData.hairType == type ? Color("Purple1") : Color.gray)
                .padding(.bottom,10)
                .overlay( // 指示器
                    ZStack{
                        if homeData.hairType == type{
                            Capsule()
                                .fill(Color("Purple1"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .padding(.horizontal,5), alignment: .bottom
                )
        }
    }
    
    /// 内容
    @ViewBuilder
    func CardView(cat: Cat)->some View{
        VStack(spacing: 10){
            ZStack{
                if sharedData.showDetailCat{
                    Image(cat.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(cat.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(cat.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            .offset(y: -80)
            .padding(.bottom,-100)
            
            Text(cat.name)
                .font(.custom("PlayfairDisplay-Regular", size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            HStack {
                Text("原产地:")
                    .font(.custom("PlayfairDisplay-Regular", size: 14)).foregroundColor(.gray)
                Text(cat.origin)
                    .font(.custom("PlayfairDisplay-Regular", size: 14))
                    .foregroundColor(.gray)
            }
            
            Text(cat.bodyType)
                .font(.custom("PlayfairDisplay-Regular", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple1"))
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.cat = cat
                sharedData.showDetailCat = true
            }
        }
    }
}


struct SearchBar: View {
    var body: some View {
        HStack(spacing: 15) {
            Image("Search")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("搜索 ", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background {
            Capsule().strokeBorder(Color.gray, lineWidth: 0.8)
        }
    }
}

struct HeadTextView: View {
    var body: some View {
        VStack {
            Text("Welcome To \n ")
                .font(.custom("PlayfairDisplay-Regular", size: 28))
                + Text("Cat Garden")
                .font(.custom("PlayfairDisplay-Bold", size: 30))
                .fontWeight(.bold)
        }
        .padding(.horizontal, 25)
        .padding(.top)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
