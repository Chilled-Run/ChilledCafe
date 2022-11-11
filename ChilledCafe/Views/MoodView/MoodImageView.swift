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
                            // magnifying gesture
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
                Text("\(images.firstIndex(of: "\(moodViewData.selectedImageID)")! + 1) / \(images.count) ")
                    .foregroundColor(.green)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .opacity(moodViewData.bgOpacity)
                    
                , alignment: .topTrailing
            )
            .overlay(
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
    }
}

struct MoodImageView_Previews: PreviewProvider {
    static var previews: some View {
        MainCategoryView()
    }
}
