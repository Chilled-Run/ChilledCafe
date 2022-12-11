//
//  StorySmallVIew.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/06.
//

import SwiftUI

struct StorySmallView: View {
    //
    @ObservedObject var firebaseSM: FirebaseStorageManager
    let storyId: String
    let story: Post
    let storyForegroundColor: Color
    let storyBackgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 유저 아이디
            Text(story.userName)
                .foregroundColor(storyForegroundColor)
                .customSubhead3()
            // 작성한 본문
            Text(story.content)
                .foregroundColor(Color.white)
                .CustomDesignedBody()
                .lineLimit(4)
                .lineSpacing(3)
                .padding(.top, UIScreen.getHeight(10))
            Spacer()
            // 메세지 개수 보여주기
            HStack {
                Spacer()
                Image(systemName: "message")
                    .resizable()
                    .foregroundColor(storyForegroundColor)
                    .frame(width: UIScreen.getWidth(18), height: UIScreen.getHeight(18))
                Text("\(firebaseSM.getCommentNumber(storyId: storyId))")
                    .customSubhead3()
                    .foregroundColor(storyForegroundColor)
            }
            .padding(.top, UIScreen.getHeight(10))
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(20)))
        .frame(width: UIScreen.getWidth(170), height: UIScreen.getHeight(170))
        //배경 설정
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(storyBackgroundColor, lineWidth: 2)
        )
        .background(storyBackgroundColor)
    }
}
//struct StorySmallVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        StorySmallView(story: constant().storySample, storyForegroundColor: Color("customGreen"), storyBackgroundColor: Color("pastelGreen"))
//    }
//}
