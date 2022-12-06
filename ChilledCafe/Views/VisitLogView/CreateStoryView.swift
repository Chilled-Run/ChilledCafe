//
//  CreateVisitPostView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/03.
//

import SwiftUI

struct CreateStroyView: View {
    
    @State var content: String = ""
    @State var placeholderText: String = "공간의 이야기를 나눠주세요!"
    @State var lastText: String = ""
    @State var words: Int = 0
    @Binding var isPopup: Bool
    
    
    var postTime: String {
        let format = DateFormatter()
        format.dateFormat = "yyyy.MM.dd"
        return format.string(from: Date())
    }
    let postImage = "bearPaw"
    //게시글 글자색
    var pawForegroundColor: Color {
        getForegroundColor(foot: postImage)
    }
    //게시글의 배경색
    var pawBackgroundColor: Color {
        getBackgroundColor(foot: postImage)
    }
    
    var body: some View {
            ZStack {
                //             배경색
                Color.black.ignoresSafeArea()
                    .opacity(0.8)
                
                VStack {
                    HStack {
                        backButton
                        Spacer()
                        if !content.isEmpty {
                            completeButton
                        }
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(57), leading: UIScreen.getWidth(30), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(30)))
                    .navigationBarHidden(true)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //첫번째 문단, 아이디, 날짜, 발자국이 보이는 곳
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("1 번째 방문한")
                                    .customTitle1()
                                Text("guest")
                                    .customLargeTitle()
                                    .padding(.top, UIScreen.getHeight(0))
                                Text("\(postTime) 다녀감")
                                    .customSubhead3()
                                    .padding(.top, UIScreen.getHeight(0))
                            }
                            .foregroundColor(pawForegroundColor)
                            Spacer()
                            Image(postImage)
                                .resizable()
                                .frame(width: 90, height: 90)
                        }
                        .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
                        
                        //두번째 문단, 본문이 보이는 곳
                        VStack(alignment: .leading) {
                            ZStack {
                                //ios 16이상의 경우
                                //texteditor의 배경을 바꾸기위한 작업
                                if #available(iOS 16.0, *) {
                                    // placeholder를 위한 texteditor
                                    if self.content.isEmpty {
                                        TextEditor(text:$placeholderText)
                                            .scrollContentBackground(.hidden)
                                            .background(pawBackgroundColor)
                                            .font(
                                                .custom("AppleSDGothicNeo-Medium", size: 16)
                                            )
                                            .foregroundColor(.gray)
                                            .disabled(true)
                                        
                                    }
                                    
                                    // 글을 쓰기 위한 texteditor
                                    TextEditor(text: $content)
                                        .scrollContentBackground(.hidden)
                                        .background(pawBackgroundColor)
                                        .opacity(self.content.isEmpty ? 0.25 : 1)
                                        .foregroundColor(.white)
                                        .font(
                                            .custom("AppleSDGothicNeo-Medium", size: 16)
                                        )
                                        .lineSpacing(4) //줄 간격
                                    // 글자수 제한
                                        .onChange(of: content) { value in
                                            self.words = content.count
                                            if self.words > 150 {
                                                self.content = self.lastText
                                            }
                                            self.lastText = self.content
                                        }
                                }
                                // ios 16 미만의 경우
                                else {
                                    // placeholder를 위한 texteditor
                                    if self.content.isEmpty {
                                        TextEditor(text:$placeholderText)
                                            .background(pawBackgroundColor)
                                            .font(
                                                .custom("AppleSDGothicNeo-Medium", size: 16)
                                            )
                                            .foregroundColor(.gray)
                                            .disabled(true)
                                        //배경지우기
                                        //UITextView의 배경을 지워야 다른 배경을 입힐 수 있다.
                                            .onAppear() {
                                                UITextView.appearance().backgroundColor = .clear
                                            }
                                        
                                    }
                                    
                                    // 글을 쓰기 위한 texteditor
                                    TextEditor(text: $content)
                                        .background(pawBackgroundColor)
                                        .opacity(self.content.isEmpty ? 0.25 : 1)
                                        .foregroundColor(.white)
                                        .font(
                                            .custom("AppleSDGothicNeo-Medium", size: 16)
                                        )
                                        .lineSpacing(4) //줄 간격
                                    // 글자수 제한
                                        .onChange(of: content) { value in
                                            self.words = content.count
                                            if self.words > 150 {
                                                self.content = self.lastText
                                            }
                                            self.lastText = self.content
                                        }
                                }
                            }
                            Spacer()
                        }
                        .frame(height: UIScreen.getHeight(133))
                        .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
                        
                        Spacer()
                        
                        //글자 수 표시
                        HStack {
                            Spacer()
                            Text("\(words)/150")
                                .customTitle1()
                                .foregroundColor(pawForegroundColor)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(30), trailing: UIScreen.getWidth(30)))
                    }
                    .frame(width: UIScreen.getWidth(340), height: UIScreen.getHeight(340))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(pawBackgroundColor, lineWidth: 2)
                    )
                    .background(pawBackgroundColor)
                    .padding(.top, UIScreen.getHeight(60))
                    Spacer()
                      
                }
                
            }
    }
    
    var backButton : some View {
        Button(action: {
            isPopup.toggle()
            content = ""
        }) {
            Image(systemName: "chevron.left.circle.fill")
                .resizable()
                .foregroundColor(Color.gray)
                .opacity(0.8)
                .frame(width: UIScreen.getWidth(40) ,height: UIScreen.getHeight(40))
                .shadow(radius:8 ,x: 0, y: 0)
        }
    }
    
    var completeButton : some View {
        Button(action: {
            let newStory = Story(storyId: UUID(), userName: "guest", visitCount: 0, context: content, image: postImage, like: false, likeCount: 0, time: postTime, comments: [])
            isPopup.toggle()
            content = ""
            
        }) {
            Text("완료")
                .customTitle1()
                .foregroundColor(Color.white)
        }
        .disabled(content.isEmpty ? true : false)
    }
}

struct CreateVisitPostView_Previews: PreviewProvider {
    static var previews: some View {
        // CreateStroyView()
        ARMainView()
    }
}


