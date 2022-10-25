//
//  MainView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/20.
//

import SwiftUI
import Kingfisher

struct MainCategoryView: View {
    @EnvironmentObject var firebaseStorageManager: FirebaseStorageManager
    static let SAMPLE_URL = "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/HotPlace%2F%E1%84%8B%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%B5%E1%86%AF%E1%84%83%E1%85%A2.jpeg?alt=media&token=6de64b0d-71be-43cd-ac0b-d3a85d6ae2bb"
    

    var body: some View {
        if firebaseStorageManager.hotPlace.isEmpty {
            Text("데이터 없음")
        } else {
            NavigationView{
                VStack{
                    HStack {
                        Image("AppNameImage")
                            .resizable()
                            .frame(width: UIScreen.getWidth(150), height: UIScreen.getHeight(32))
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(10), trailing: 0))
                    
                    HStack {
                        Text("가볍게 즐기는 색다른 경험")
                            .customSubhead4()
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(40), trailing: 0))
                    
                    HStack(spacing: UIScreen.getWidth(10)) {
                        categoryCardView(imageURL: firebaseStorageManager.hotPlace[0].imageURL, spot: firebaseStorageManager.hotPlace[0].spot, description: firebaseStorageManager.hotPlace[0].description)
                        categoryCardView(imageURL: firebaseStorageManager.hotPlace[1].imageURL, spot: firebaseStorageManager.hotPlace[1].spot, description: firebaseStorageManager.hotPlace[1].description)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(15), trailing: 0))
                    
                    HStack(spacing: UIScreen.getWidth(10)) {
                        categoryCardView(imageURL: firebaseStorageManager.hotPlace[2].imageURL, spot: firebaseStorageManager.hotPlace[2].spot, description: firebaseStorageManager.hotPlace[2].description)
                        categoryCardView(imageURL: firebaseStorageManager.hotPlace[3].imageURL, spot: firebaseStorageManager.hotPlace[3].spot, description: firebaseStorageManager.hotPlace[3].description)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0,  bottom: UIScreen.getHeight(15), trailing: 0))
                    Spacer()
                }
                .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
            }
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    func categoryCardView(imageURL: String = SAMPLE_URL, spot: String = "영일대", description: String = "바다 앞 카페를 찾는다면") -> some View {
        NavigationLink(destination: CafeListView(navigationTitle: spot)) {
            ZStack {
                KFImage(URL(string: imageURL)!)
                    .resizable()
                    .aspectRatio(0.57, contentMode: .fit)
                    .overlay {
                        VStack {
                            Spacer()
                            HStack {
                                Text(spot)
                                    .customTitle3()
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(1), trailing: 0))
                                Spacer()
                            }
                            HStack {
                                Text(description)
                                    .customSubhead2()
                                    .lineLimit(1)
                                Spacer()
                            }
                        }
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: 0))
                    }
            }
        }
        .navigationTitle("")
    }
    
}



//struct MainCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainCategoryView()
//    }
//}


