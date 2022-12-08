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
            }
            .frame(width: UIScreen.getWidth(340), height: UIScreen.getHeight(340))
            //배경 밑에 20만큼 더 채우기위해
            .padding(.bottom, UIScreen.getHeight(20))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(pawBackgroundColor, lineWidth: 4)
            )
            .background(pawBackgroundColor)
            .padding(.top, 50)
            
            //댓글 리스트
            VStack(alignment: .leading) {
                ScrollView {
                    ForEach(post.comments, id: \.self.commentId) { comment in
                        VStack {
                            Rectangle()
                                .fill(pawForegroundColor)
                                .frame(width: UIScreen.getWidth(350), height: 1)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(comment.userName)
                                        .customSubhead2()
                                        .foregroundColor(pawForegroundColor)
                                        .padding(.top, UIScreen.getHeight(16))
                                    Spacer()
                                }
                                HStack {
                                    Text(comment.context)
                                        .customSubhead4()
                                        .foregroundColor(pawForegroundColor)
                                        .lineLimit(4)
                                        .lineSpacing(3)
                                        .padding(.bottom, UIScreen.getHeight(16))
                                }
                            }
                        }
                    }
                }
                // .scrollContentBackground(.hidden)
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
            .onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
            }
        }
    }
}
