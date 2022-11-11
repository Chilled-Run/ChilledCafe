//
//  MainView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/10.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("AppTitle")
                        .resizable()
                        .frame(width: UIScreen.getWidth(100), height: UIScreen.getHeight(30))
                    Spacer()
                    Image("bookmarks")
                        .resizable()
                        .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                }
                .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(20)))
                // 스크롤 메뉴
                HorizontalScrollMenuBarView()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(20), trailing: 0))
                
                // 카페 리스트
                FullCardScrollView()
                    .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
                
                Spacer()
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}