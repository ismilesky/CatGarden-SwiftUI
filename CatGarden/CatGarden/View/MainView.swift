//
//  ContentView.swift
//  CatGarden
//
//  Created by edy on 2023/6/14.
//

import SwiftUI

struct MainView: View {
    
    let catStore = CatStore()
    
    @State var currentTab: Tab = .home
    @Namespace var animation
    
    @StateObject var sharedData: ShareDataModel = ShareDataModel()
//    @StateObject var homeData: HomeViewModel = HomeViewModel()

    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
       
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeView(animation: animation)
                    .environmentObject(sharedData)
//                    .environmentObject(homeData)
                    .tag(Tab.home)
                CollectView()
                    .environmentObject(sharedData)
                    .tag(Tab.category)
                
                ProfileView()
                    .tag(Tab.profile)
            }
            TabBar(currentTab: $currentTab)
                .opacity(sharedData.searchActivated ? 0 : 1)
        }
        .background(Color("Bg").ignoresSafeArea())
        .overlay(
            ZStack{
                if let cat = sharedData.cat,sharedData.showDetailCat {
                    DetailView(cat: cat, animation: animation).environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}


struct TabBar: View {
    @Binding var currentTab: Tab

    var body: some View {
        HStack(spacing: 0.0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut) {
                        currentTab = tab
                    }
                } label: {
                    Image(tab.rawValue)
                        .renderingMode(.template)
                        .frame(width: 22, height: 22)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(currentTab == tab ? Color("Purple1") : Color.black.opacity(0.3))
                }
            }
        }
//        .frame(height: 40)
//            .background(.red)
        .padding([.horizontal, .top])
        .background(Color("Bg").ignoresSafeArea())

//            .padding(.top, 20)
//            .clipShape(Capsule())
//            .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
    }
}


enum Tab: String, CaseIterable {
    case home = "Home"
    case category = "Category"
    case profile = "Profile"
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
