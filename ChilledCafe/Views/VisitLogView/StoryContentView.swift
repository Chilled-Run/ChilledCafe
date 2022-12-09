//
//  StoryContetView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/08.
//

import SwiftUI

struct StoryContentView: View {
    let post: Story
    let pawForegroundColor: Color
    let pawBackgroundColor: Color
    let otherFootPrintName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //첫번째 문단, 아이디, 날짜, 발자국이 보이는 곳
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(post.visitCount)번 방문한")
                        .customTitle1()
                    Text(post.userName)
                        .customLargeTitle()
                        .padding(.top, UIScreen.getHeight(10))
                    Text("\(post.time) 다녀감")
                        .customSubhead3()
                        .padding(.top, UIScreen.getHeight(10))
                }
                .foregroundColor(pawForegroundColor)
                Spacer()
                Image(otherFootPrintName)
                    .resizable()
                    .frame(width: 90, height: 90)
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
            
            //두번째 문단, 본문이 보이는 곳
            VStack(alignment: .leading) {
                Text(post.context)
                    .customSubhead4()
                Spacer()
            }
            .foregroundColor(Color.white)
            .frame(height: UIScreen.getHeight(100))
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
        }
    }
}


