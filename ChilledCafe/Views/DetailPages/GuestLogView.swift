//
//  GuestLogView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/30.
//

import SwiftUI

struct GuestLogView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Text("공간 스토리 (32)")
                    .customTitle2()
                Spacer()
            }
            // Story로 이어지는 뷰
            // 모든 사람들에게 보여지는 공간 이야기
            if firebaseSM.post.count >= 2 {
                HStack(spacing: 8) {
                    NavigationLink(destination: CommnetView(firebaseSM: firebaseSM, storyId: firebaseSM.post[0].storyId)) {
                        StorySmallView(firebaseSM: firebaseSM, storyId: firebaseSM.post[0].storyId, story: firebaseSM.post[0], storyForegroundColor: getForegroundColor(foot: firebaseSM.post[0].image), storyBackgroundColor: getBackgroundColor(foot: firebaseSM.post[0].image))
                    }
                    NavigationLink(destination: CommnetView(firebaseSM: firebaseSM, storyId: firebaseSM.post[1].storyId)){
                        StorySmallView(firebaseSM: firebaseSM, storyId: firebaseSM.post[1].storyId, story: firebaseSM.post[1], storyForegroundColor:  getForegroundColor(foot: firebaseSM.post[1].image), storyBackgroundColor: getBackgroundColor(foot: firebaseSM.post[1].image))
                    }
                }
                .padding(.top, UIScreen.getHeight(20))
            }
            // 그라데이션을 위한 ZStack
            ZStack {
                // 방문인증 후 보여지는 공간이야기
                HStack(spacing: 8) {
                    if firebaseSM.post.count >= 4 {
                        StorySmallView(firebaseSM: firebaseSM, storyId: firebaseSM.post[2].storyId, story: constant().post, storyForegroundColor: getForegroundColor(foot: firebaseSM.post[2].image), storyBackgroundColor: getBackgroundColor(foot: firebaseSM.post[2].image))
                        
                        StorySmallView(firebaseSM: firebaseSM, storyId: firebaseSM.post[3].storyId, story: constant().post, storyForegroundColor:  getForegroundColor(foot: firebaseSM.post[3].image), storyBackgroundColor:  getForegroundColor(foot: firebaseSM.post[3].image))
                    }
                    
                }
                // ZStack 위에 올라가는 방문 인증을 위한 뷰
                VStack(spacing: 0) {
                    Image(systemName: "lock")
                        .foregroundColor(Color("MainColor"))
                        .frame(width: UIScreen.getWidth(17), height: UIScreen.getHeight(19))
                        .padding(UIScreen.getHeight(10))
                    
                    Text("방문자 로그를 잠금해제하려면")
                        .customSubhead4()
                        .foregroundColor(Color("MainColor"))
                        .padding(.top, UIScreen.getHeight(10))
                    
                    Text("방문 인증이 필요해요")
                        .customSubhead4()
                        .foregroundColor(Color("MainColor"))
                    
                    VStack {
                        NavigationLink(destination: ARMainView(firebaseSM: firebaseSM)) {
                            HStack(spacing: 6) {
                                Image("foot")
                                    .resizable()
                                    .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                                Text("방문 인증하기")
                                    .customSubhead4()
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .frame(width: UIScreen.getWidth(280),height: UIScreen.getHeight(50))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("MainColor"), lineWidth: 2)
                    )
                    .background(Color("MainColor"))
                    .padding(.top, UIScreen.getHeight(20))
                }
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(188))
                .padding(.top, 0)
                .background(Color.white)
                .mask(
                    // 그래디언트 설정
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                )
            }
            // ZStack 끝
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
    }
}

//struct GuestLogView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuestLogView()
//    }
//}
