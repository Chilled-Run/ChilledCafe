//
//  MainView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/10.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    @AppStorage("isFirst") var ifFirst: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Image("AppTitle")
                    .resizable()
                    .frame(width: UIScreen.getWidth(60), height: UIScreen.getHeight(24))
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                    .foregroundColor(Color("MainColor"))
                
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(20)))
            
            // MARK: - 스크롤 메뉴
            HorizontalScrollMenuBarView(category: Array(firebaseSM.cafeList.keys).sorted(), firebaseSM: firebaseSM)
                .padding(0)
            
            // MARK: - 카페 리스트
            FullCardScrollView(firebaseSM: firebaseSM)
                .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear() {
            firebaseSM.fetchComment()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(firebaseSM: FirebaseStorageManager(), ifFirst: true)
    }
}
