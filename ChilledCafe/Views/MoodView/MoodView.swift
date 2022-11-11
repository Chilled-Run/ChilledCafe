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
    let images: [String]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columnGrid,  alignment: .center, spacing: 1) {
                
                // TODO: images --> cafe.moodImages
                
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
                                .frame(width: UIScreen.main.bounds.width / 2.2 - 1)
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
                        .frame(height: UIScreen.main.bounds.size.height)
                    
                    MoodImageView(images: images)
                }
            }
        )
        .environmentObject(moodViewData)
        
    }
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }
        }
    }
    
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        MainCategoryView()
    }
}
