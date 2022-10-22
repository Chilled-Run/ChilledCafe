//
//  CafeListView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/22.
//

import SwiftUI
import ACarousel

struct CafeListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var currentIndex: Int = 0
    var navigationTitle: String
    let roles = ["형산강", "형산강", "형산강", "형산강", "형산강"]
    
    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ZStack(alignment: .top) {
                    ACarousel(roles, id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: .active(5)) { name in
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 0)
                        
                    }
                    .frame(height: UIScreen.getHeight(515))
                    VStack {
                        Spacer()
                        HStack {
                            ForEach(Array(roles.enumerated()), id: \.offset) { index, element in
                                if index == currentIndex {
                                    Image("filledbox")
                                } else {
                                    Image("box")
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
                
                Spacer()
                VStack {
                    ForEach(1..<100) {
                        Text("Item \($0)") //$표시 필수
                            .font(.title)
                    }
                }
                
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(navigationTitle, displayMode: .inline)
            .navigationBarItems(leading: backButton)
            .foregroundColor(.black)
        }
        .ignoresSafeArea()
        
    }
    
    // 네비게이션 뷰 뒤로가기 버튼
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
            }
        }
    }
}



struct CafeListView_Previews: PreviewProvider {
    static var previews: some View {
        CafeListView(navigationTitle: "포항 형산강")
    }
}
