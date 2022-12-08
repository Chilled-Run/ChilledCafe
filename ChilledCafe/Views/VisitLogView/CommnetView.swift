//
//  CommnetView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/08.
//

import SwiftUI

struct CommnetView: View {
    let post: Story
    let pawForegroundColor: Color
    let pawBackgroundColor: Color
    let otherFootPrintName: String
    
    var body: some View {
        VStack {
            // 본문
            VStack {
                StoryContetView(post: post, pawForegroundColor: pawForegroundColor, pawBackgroundColor: pawBackgroundColor, otherFootPrintName: otherFootPrintName)
                    .padding(.bottom, UIScreen.getHeight(20))
            }
            .frame(width: UIScreen.getWidth(340), height: UIScreen.getHeight(340))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(pawBackgroundColor, lineWidth: 4)
            )
            .background(pawBackgroundColor)
            //댓글 리스트
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(post.comments, id: \.self.commentId) {
                        Rectangle()
                            .fill(pawForegroundColor)
                            .frame(height: 1)
                        Text($0.userName)
                            .customSubhead2()
                            .foregroundColor(pawForegroundColor)
                            .padding(.top, UIScreen.getHeight(16))
                        Text($0.context)
                            .customSubhead4()
                            .foregroundColor(pawForegroundColor)
                            .lineLimit(4)
                            .lineSpacing(3)
                    }
                    Rectangle()
                        .fill(pawForegroundColor)
                        .frame(height: 1)
                }
            }
            .frame(height: <#T##CGFloat?#>)
            .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
        }
    }
}
