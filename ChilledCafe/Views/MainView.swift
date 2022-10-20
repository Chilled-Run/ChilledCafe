//
//  MainView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/20.
//


import SwiftUI

struct MainView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let appName = "앱 이름"
    
    var body: some View {
        NavigationView{
            VStack{
               Text(appName)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(constant.HotPlaceArray, id: \.self) { hotPlace in
                        NavigationLink{
                            CategoryView()
                            
                        }
                    label:{
                            MainCardView(hotPlace: hotPlace)
                        }
                    }
                }
            }
        }
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
