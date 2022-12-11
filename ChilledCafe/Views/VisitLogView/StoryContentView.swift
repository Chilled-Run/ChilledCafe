//
//  StoryContetView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/08.
//

import SwiftUI

struct StoryContentView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    let dateFormatter = DateFormatter()
   
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //첫번째 문단, 아이디, 날짜, 발자국이 보이는 곳
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(firebaseSM.selectedPost.visitCount) 번 방문한")
                        .customTitle1()
                    Text(firebaseSM.selectedPost.userName)
                        .customLargeTitle()
                        .padding(.top, UIScreen.getHeight(10))
                    Text("2022.12.12") 다녀감"
                        //"2022.12.12 다녀감"
                    )
                        .customSubhead3()
                        .padding(.top, UIScreen.getHeight(10))
                }
                .foregroundColor(firebaseSM.pawForegroundColor)
                
                Spacer()
                Image(firebaseSM.selectedPost.image)
                    .resizable()
                    .frame(width: 90, height: 90)
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
            .onAppear() {
                dateFormatter.dateFormat = "yyyy.MM.dd"
                
            }
            //두번째 문단, 본문이 보이는 곳
            VStack(alignment: .leading) {
                Text(firebaseSM.selectedPost.content)
                    .customSubhead4()
                Spacer()
            }
            .foregroundColor(Color.white)
            .frame(height: UIScreen.getHeight(100))
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
        }
    }
}


