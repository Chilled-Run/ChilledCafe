//
//  MainView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/10.
//

import SwiftUI

struct MainView: View {
    @StateObject var firebaseSM: FirebaseStorageManager = FirebaseStorageManager()
    
    var body: some View {
            VStack {
                HStack {
                    Image("AppTitle")
                        .resizable()
                        .frame(width: UIScreen.getWidth(100), height: UIScreen.getHeight(30))
                    Spacer()
                    NavigationLink(destination: {
                        MyBookmarkView(firebaseSM: firebaseSM)
                    }) {
                        Image("bookmarks")
                            .resizable()
                            .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                    }
                }
                .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(20)))
                // MARK: - 스크롤 메뉴
                HorizontalScrollMenuBarView(category: Array(firebaseSM.cafeListClassification.keys).sorted(), firebaseSM: firebaseSM)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(20), trailing: 0))
                
                // MARK: - 카페 리스트
                FullCardScrollView(firebaseSM: firebaseSM)
                    .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
                
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .ignoresSafeArea(.all, edges: .bottom)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
