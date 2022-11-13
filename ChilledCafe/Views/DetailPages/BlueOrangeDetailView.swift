//
//  BlueOrangeDetailView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/10.
//

import SwiftUI
import Kingfisher
import ACarousel

struct BlueOrangeDetailView: View {
    @State var currentIndex: Int = 0
    let sample = constant().sample
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                //스크롤 뷰 고정
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        
                        //carousel nav
                        NavigationLink(destination: MoodView(images: sample.moodImages )) {
                            
                            ZStack(alignment: .top) {
                                
                                // MARK: 카페 캐러셀 이미지
                                ACarousel(sample.moodImages, id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: .active(5)) {_ in
                                    KFImage(URL(string: sample.moodImages[currentIndex]))
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
                                HStack{
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black)
                                        .opacity(0.4)
                                        .frame(width:UIScreen.getWidth(42), height:UIScreen.getHeight(24))
                                        .overlay(
                                            Text("\(currentIndex + 1)" + "/" + "\(sample.moodImages.count)")
                                                .customSubhead3()
                                                .foregroundColor(Color.white)
                                        )
                                }
                                .padding(EdgeInsets(top: UIScreen.getHeight(256), leading: 0, bottom: 0, trailing: UIScreen.getWidth(20)))
                                
                            }
                            //carousel height
                            .frame(height: UIScreen.getHeight(300))
                            
                        }
                        DetailInfoView(sample: sample)
                        Spacer()
                    }
                }
                
                // MARK: 플로팅 버튼
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        arButtonView()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(34), trailing: UIScreen.getWidth(20)))
            }
            .ignoresSafeArea(.all)
        }
    }
}
struct BlueOrangeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BlueOrangeDetailView()
    }
}

// MARK: AR 버튼

@ViewBuilder
func arButtonView() -> some View {
    Button(action: {}) {
        Circle()
            .fill(Color("MainColor"))
            .frame(width: UIScreen.getWidth(60), height: UIScreen.getWidth(60))
            .overlay(
                Image("ar")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.white)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            )
            .shadow(radius: 4, x: 0, y: 4)
    }
}