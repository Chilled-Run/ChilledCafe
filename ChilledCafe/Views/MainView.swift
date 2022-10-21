//
//  MainView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/20.
//


import SwiftUI
import Firebase
import FirebaseStorage

struct MainView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let appName = "앱 이름"
    @State var hotPlaces: [HotPlace] = []
    
    var body: some View {
        NavigationView{
            VStack{
               Text(appName)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(hotPlaces, id: \.self) { hotPlace in
                        NavigationLink{
                            CategoryView()
                            
                        }
                    label:{
                            MainCardView(hotPlace: hotPlace)
                        }
                    }
                }
            }
            .onAppear(){
               hotPlaces = FirebaseStorageManager.getHotPlace() ?? []

            }
        }
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
