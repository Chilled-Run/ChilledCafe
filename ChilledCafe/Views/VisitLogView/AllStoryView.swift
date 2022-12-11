//
//  AllStoryView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/11.
//

import SwiftUI

struct AllStoryView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    
    let columns = [
           GridItem(.flexible(), spacing: nil, alignment: nil),
           GridItem(.flexible(), spacing: nil, alignment: nil)
       ]
    var body: some View {
        VStack {
            VStack {
                HStack {
                    backButton
                    Spacer()
                    Text("방문자 로그")
                        .customTitle1()
                        .foregroundColor(Color("MainColor"))
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
                .overlay(
                Rectangle()
                    .stroke(Color.white, lineWidth: 1)
                )
                .background(Color.white)
            }
            .padding(.top, UIScreen.getHeight(47))
                     
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(firebaseSM.post, id: \.self.storyId) { index in
                        StorySmallView(firebaseSM: firebaseSM, storyId: index.storyId, story: index, storyForegroundColor: getForegroundColor(foot: index.image), storyBackgroundColor: getBackgroundColor(foot: index.image))
                    }
                }
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
        }
        .ignoresSafeArea(.all)
    }
    
    var backButton : some View {
        Button(action: {
          
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .foregroundColor(Color("MainColor"))
                    .frame(width: UIScreen.getWidth(10) ,height: UIScreen.getHeight(19))
            }
        }
    }
}

