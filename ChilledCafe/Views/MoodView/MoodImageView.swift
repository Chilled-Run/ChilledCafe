//
//  MoodImageView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/11/12.
//

import SwiftUI
import Kingfisher

struct MoodImageView: View {
    var images: [String]
    @EnvironmentObject var moodViewData: MoodViewModel
    @GestureState var draggingOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            TabView(selection: $moodViewData.selectedImageID) {
                ForEach(images, id: \.self) { image in
                    KFImage(URL(string: image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .tag(image)
                        .scaleEffect(moodViewData.selectedImageID == image ? (moodViewData.imageScale > 1 ? moodViewData.imageScale : 1) : 1)
                    
                        .offset(y: moodViewData.imageViewerOffset.height)
                        .gesture(
                            // 확대 제스쳐
                            MagnificationGesture().onChanged({ (value) in
                                moodViewData.imageScale = value
                                
                            }).onEnded({ (_) in
                                withAnimation(.spring()) {
                                    moodViewData.imageScale = 1
                                }
                            })
                        )
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(
                
                // MARK: 사진 인덱스
                
                Text("\(images.firstIndex(of: "\(moodViewData.selectedImageID)")! + 1)/\(images.count) ")
                    .foregroundColor(.white)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .opacity(moodViewData.bgOpacity)
                
                , alignment: .topTrailing
            )
            .overlay(
                
                // MARK: 닫기 버튼
                
                Button(action: {
                    withAnimation(.default) {
                        moodViewData.showImageViewer.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                })
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .opacity(moodViewData.bgOpacity)
                
                ,alignment: .topLeading
            )
        }
        .gesture(DragGesture().updating($draggingOffset, body: { (value, outValue, _) in
            outValue = value.translation
            moodViewData.onChange(value: draggingOffset)
            
        }).onEnded(moodViewData.onEnd(value:)))
        .transition(.move(edge:.bottom))
        .navigationBarHidden(true)
    }
}

struct MoodImageView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
