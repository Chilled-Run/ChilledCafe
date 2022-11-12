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
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    NavigationLink(destination: MoodView(images: sample.moodImages )) {
                        ZStack(alignment: .top) {
                            // MARK: 카페 이미지에 대한 캐러셀
                            ACarousel(sample.moodImages, id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: .active(5)) {_ in
                                KFImage(URL(string: sample.moodImages[currentIndex]))
                                    .placeholder{
                                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                                    }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(300))
                            }
                            Image("gradient")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.getHeight(111))
                            
                            // MARK: 캐러셀에서 현재 보여주는 사진의 인덱스를 나타내는 뷰
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
                            } .padding(EdgeInsets(top: UIScreen.getHeight(256), leading: 0, bottom: 0, trailing: UIScreen.getWidth(20)))
                        }
                        .frame(height: UIScreen.getHeight(300))
                    }
                    DetailInfoView(sample: sample)
                    Spacer()
                }
                .frame(height: UIScreen.getHeight(810))
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



