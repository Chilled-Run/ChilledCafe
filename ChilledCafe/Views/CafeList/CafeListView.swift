//
//  CafeListView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/22.
//

import SwiftUI
import ACarousel
import Kingfisher

struct CafeListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var firebaseStorageManager: FirebaseStorageManager
    @State var currentIndex: Int = 0
    @State var detailViewIndex: Int = 0
    @State var checkingCarousel : Bool = true
    
    let likedCafeText = "🥰 내가 좋아한 카페"
    let recommendedCafeText = "내 취향에 맞는 카페"
    var navigationTitle: String
    
    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        if firebaseStorageManager.cafeClassification.isEmpty {
            Text("데이터 없음")
                .onAppear(perform: {
                    firebaseStorageManager.getCafes(spot: navigationTitle)
                })
        } else {
            GeometryReader {geo in
                let topEdge: CGFloat = geo.safeAreaInsets.top
                ScrollView(.vertical) {
                    VStack {
                        Group{
                            NavigationLink(destination: CafeDetailView(topEdge: 40, cafe: firebaseStorageManager.cafeClassification[recommendedCafeText]![checkingCarousel ? detailViewIndex : currentIndex])){
                                ZStack(alignment: .top) {
                                    ACarousel(firebaseStorageManager.cafeClassification[recommendedCafeText] ?? [], id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: checkingCarousel ?  .inactive : .active(5)) {
                                        recommendCafeView(imageURL: $0.thumbnail, name: $0.name, shortIntroduction: $0.shortIntroduction)
                                    }
                                    .frame(height: UIScreen.getHeight(515))
                                    .onAppear(){
                                        checkingCarousel.toggle()
                                    }
                                    .onDisappear(){
                                        checkingCarousel.toggle()
                                        detailViewIndex = currentIndex
                                    }
                                    VStack {
                                        HStack {
                                            Text(recommendedCafeText)
                                                .customHeadline()
                                                .foregroundColor(Color.white)
                                            Spacer()
                                        }
                                        .padding(EdgeInsets(top: UIScreen.getHeight(116), leading: UIScreen.getWidth(20), bottom: 0, trailing: 0))
                                        Spacer()
                                        HStack {
                                            ForEach(Array(firebaseStorageManager.cafeClassification[recommendedCafeText]!.enumerated()), id: \.offset) { index, element in
                                                if index == currentIndex {
                                                    Image("filledbox")
                                                } else {
                                                    Image("box")
                                                }
                                            }
                                            Spacer()
                                        }
                                        .padding()
                                    }}
                            }
                        }
                        
                        VStack {
                            // MARK: - 내가 좋아한 카페
                            Group{
                                HStack {
                                    Text(likedCafeText)
                                        .customTitle2()
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: UIScreen.getHeight(0), leading: UIScreen.getWidth(10), bottom: UIScreen.getHeight(20), trailing: 0))
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack (spacing: 10) {
                                        RoundedRectangle(cornerRadius: 1)
                                            .frame(width: UIScreen.getWidth(1))
                                            .hidden()
                                        ForEach(firebaseStorageManager.cafeClassification[likedCafeText]!, id: \.self) { cafe in
                                            NavigationLink(destination: CafeDetailView(topEdge: 40, cafe: cafe)){
                                                TransparentLikedCafeCardView(thumbnail: cafe.thumbnail, name: cafe.name, shortIntroduction: cafe.shortIntroduction)
                                            }
                                        }
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(40), trailing: 0))
                            }
                            
                            // MARK: - 태그 별 카페
                            ForEach(Array(firebaseStorageManager.cafeClassification.keys), id: \.self, content: { key in
                                if key != recommendedCafeText && key != likedCafeText {
                                    HStack {
                                        Text(key)
                                            .customTitle2()
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(10), bottom: 0, trailing: 0))
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 10) {
                                            RoundedRectangle(cornerRadius: 1)
                                                .frame(width: UIScreen.getWidth(1))
                                                .hidden()
                                            ForEach(firebaseStorageManager.cafeClassification["\(key)"]!, id: \.self) { cafe in
                                                NavigationLink(destination: CafeDetailView(topEdge: 40, cafe: cafe)){
                                                    CardView(thumbnail: cafe.thumbnail, name: cafe.name, shortIntroduction: cafe.shortIntroduction)
                                                }
                                            }
                                        }
                                    }
                                    .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: 0, bottom: UIScreen.getHeight(40), trailing: 0))
                                }
                            })
                        }
                        .padding(EdgeInsets(top: UIScreen.getHeight(40), leading: 0, bottom: 0, trailing: 0))
                    }
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle(navigationTitle, displayMode: .inline)
                    .navigationBarItems(leading: backButton)
                    .foregroundColor(.black)
                }
                .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    func recommendCafeView(imageURL: String, name: String, shortIntroduction: String ) -> some View {
        ZStack {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(515))
                .overlay(content: {
                    Color.black
                        .opacity(0.5)
                })
            
            VStack {
                Spacer()
                HStack {
                    Text(name)
                        .customLargeTitle()
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(5), trailing: 0))
                HStack {
                    Text(shortIntroduction)
                        .customHeadline()
                        .lineLimit(1)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(40), trailing: 0))
            .foregroundColor(.white)
        }
        
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
            .environmentObject(FirebaseStorageManager())
    }
}
