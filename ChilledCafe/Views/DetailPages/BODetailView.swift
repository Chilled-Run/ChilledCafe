//
//  BODetailView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/13.
//


import SwiftUI
import Kingfisher
import ACarousel


struct BODetailView: View {
    @State var currentIndex: Int = 0
    @State var cafe: Cafes = constant().sample
    var firebaseSM: FirebaseStorageManager
    var index: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
     
            ZStack {
                //스크롤 뷰 고정
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        
                        //carousel nav
                        NavigationLink(destination: MoodView(images: cafe.moodImages )) {
                            
                            ZStack(alignment: .top) {
                                
                                // MARK: 카페 캐러셀 이미지
                                ACarousel(cafe.moodImages, id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: .active(5)) {_ in
                                    KFImage(URL(string: cafe.moodImages[currentIndex]))
                                        .placeholder{
                                            ProgressView().progressViewStyle(CircularProgressViewStyle())
                                        }
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(300))
                                }
                                
                                //gradient effect
                                Image("gradient")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.getHeight(111))
                                
                                // MARK: 캐러셀 인덱스
                                HStack {
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black)
                                        .opacity(0.4)
                                        .frame(width:UIScreen.getWidth(42), height:UIScreen.getHeight(24))
                                        .overlay(
                                            Text("\(currentIndex + 1)" + "/" + "\(cafe.moodImages.count)")
                                                .customSubhead3()
                                                .foregroundColor(Color.white)
                                        )
                                }
                                .padding(EdgeInsets(top: UIScreen.getHeight(256), leading: 0, bottom: 0, trailing: UIScreen.getWidth(20)))
                                
                            }
                            
                            //carousel height
                            .frame(height: UIScreen.getHeight(300))
                            
                        }
                        .navigationBarHidden(true)
                        
                        DetailInfoView(firebaseSM: firebaseSM, index: index)
                        Spacer(minLength: UIScreen.getHeight(110))
                    }
                    
                }
                .onAppear() {
                    cafe = firebaseSM.getSelectedCafe(index: index)
                }
                
                
                // MARK: 플로팅 버튼
                VStack {
                    HStack {
                        backButton
                        Spacer()
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(57), leading: UIScreen.getWidth(17), bottom: 0, trailing: 0))
                    Spacer()
                    HStack {
                        Spacer()
                        if cafe.ar {
                            arButtonView
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(34), trailing: UIScreen.getWidth(20)))
            }
            .ignoresSafeArea(.all)
    }
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .foregroundColor(Color("MainColor"))
                    .frame(width: UIScreen.getWidth(10) ,height: UIScreen.getHeight(19))
            }
            
        }
    }
    
    // MARK: AR 버튼
    
    var arButtonView : some View {
        Button(action: {}) {
            Circle()
                .fill(Color("MainColor"))
                .frame(width: UIScreen.getWidth(60), height: UIScreen.getWidth(60))
                .overlay(
                    Image("ar")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.white)
                )
                .shadow(radius: 4, x: 0, y: 4)
        }
    }
}

struct BODetailView_Previews: PreviewProvider {
    static var previews: some View {
        BODetailView(cafe: constant().sample, firebaseSM: FirebaseStorageManager(), index: 0)
    }
}


