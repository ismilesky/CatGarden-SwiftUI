//
//  ProfileView.swift
//  CatGarden
//
//  Created by edy on 2023/6/17.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("猫掌柜资料")
                        .font(.custom("PlayfairDisplay-Regular", size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    MasterView()
                    
                    ItemView(title: "Edit Profile", imageName: "highlighter")
                    ItemView(title: "Contacts", imageName: "iphone.gen3.badge.play")
                    ItemView(title: "Cats Email", imageName: "envelope.badge")
                    ItemView(title: "Notifications", imageName: "bell.badge")
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
            .background {
                Color("Bg")
                    .ignoresSafeArea()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// Master
struct MasterView: View {
    var body: some View {
        VStack(spacing: 15){
            Image("Dragon_Li")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .offset(y: -40)
                .padding(.bottom,-40)
            
            Text("阿狸")
                .font(.custom("PlayfairDisplay-Regular", size: 18))
                .fontWeight(.semibold)
            
            HStack(alignment: .top, spacing: 10) {
                
                Image(systemName: "location.north.circle.fill")
//                    .foregroundColor(.gray)
                    .rotationEffect(.init(degrees: 180))
                
                Text("中国狸花猫, 产地中国\n花园主/猫掌柜, 管理花园若干只猫")
                    .font(.custom("PlayfairDisplay-Regular", size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding([.horizontal,.bottom])

        .background {
            Color.white
                .cornerRadius(12)
        }
        .padding()
        .padding(.top,40)
    }
}

// item
struct ItemView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        NavigationLink {
            Text("")
                .navigationTitle(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("HomeBG").ignoresSafeArea())
        } label: {
            
            HStack{
                Image(systemName: imageName)
                
                Text(title)
                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                    .fontWeight(.semibold)
                    .padding(.leading, 10)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
