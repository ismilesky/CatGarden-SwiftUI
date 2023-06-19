//
//  OnBoardingView.swift
//  CatGarden
//
//  Created by edy on 2023/6/16.
//

import SwiftUI

struct OnBoardingView: View {
    @State var showHome: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text("Find \nCat Garden")
                .font(.custom("PlayfairDisplay-Regular", size: 45))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image("slash-face")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation{
                    showHome = true
                }
            } label: {
                Text("Get Started")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple1"))
            }
            .padding(.horizontal,30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top,getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple1"))
        .overlay(
            Group{
                if showHome {
                    MainView()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}



struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
