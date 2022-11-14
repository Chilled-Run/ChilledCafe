//
//  GalleryView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/11.
//

import SwiftUI
import Kingfisher
import Firebase

struct MoodView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var moodViewData = MoodViewModel()
    
    var columnGrid: [GridItem] = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
    
    // TODO: images --> cafe.moodImages
    // 추후 데이터베이스 연동 후 객체를 변동해야합니다.
    let images: [String]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columnGrid,  alignment: .center, spacing: 1) {
                
                // TODO: images --> cafe.moodImages
                // 추후 데이터베이스 연동 후 객체를 변동해야합니다.
                ForEach (images.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            moodViewData.selectedImageID = images[index]
                            moodViewData.showImageViewer.toggle()
                        }
                    }, label: {
                        ZStack {
                            KFImage(URL(string: images[index]))
                                .placeholder {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                                }
                                .resizable()
                                .cornerRadius(4)
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth / 2.2 - 1)
                        }
                    })
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 150)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("분위기 보기", displayMode: .inline)
        .navigationBarItems(leading: backButton)
        .overlay(
            ZStack {
                if moodViewData.showImageViewer {
                    Color.black
                        .opacity(moodViewData.bgOpacity)
                        .ignoresSafeArea()
                        .frame(height: UIScreen.screenHeight)
                    
                    MoodImageView(images: images)
                }
            }
        )
        .environmentObject(moodViewData)
        
    }
    
    // MARK: 뒤로가기 버튼
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color("MainColor"))
            }
        }
    }
    
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
