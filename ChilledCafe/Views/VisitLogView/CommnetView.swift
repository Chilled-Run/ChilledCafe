//
//  CommnetView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/08.
//

import SwiftUI

struct CommnetView: View {
    @State var isToggleLike = false
    @State var text: String = ""
    @State var textHeight: CGFloat = 16
    @FocusState private var isFocused: Bool
    
    @Binding var isCommentView: Bool
    @ObservedObject var firebaseSM: FirebaseStorageManager
    let storyId: String
    let status: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack {
                Color.white
                VStack(spacing: 0) {
                    //네비게이션 바
                    ZStack {
                        HStack {
                            backButton
                            Spacer()
                        }
                        HStack(alignment: .center) {
                            Text("댓글보기")
                                .customTitle1()
                                .foregroundColor(Color("MainColor"))
                        }
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
                    .navigationBarHidden(true)
                    // forTest
                    .onAppear() {
                        firebaseSM.storyId = storyId
                        firebaseSM.getStory(storyId: storyId)
                        firebaseSM.fetchRelatedComment(storyId: storyId)
                    }
                    // 본문
                    VStack(spacing: 0) {
                        StoryContentView(firebaseSM: firebaseSM)
                        //세번째 문단, 좋아요, 댓글의 개수가 보이는 곳
                        Spacer()
                        HStack {
                            Button(action: {isToggleLike.toggle()}){
                                if isToggleLike {
                                    HStack(spacing: 4) {
                                        Image(systemName: "heart.fill")
                                        Text("1")
                                    }
                                }
                                else {
                                    HStack(spacing: 4) {
                                        Image(systemName: "heart")
                                        Text("0")
                                    }
                                }
                            }
                            HStack(spacing: 4) {
                                Image(systemName: "message")
                                Text("\(firebaseSM.relatedComments.count)")
                            }
                            Spacer()
                        }
                        .foregroundColor(firebaseSM.pawForegroundColor)
                        .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
                    }
                    .frame(width: UIScreen.getWidth(340), height: UIScreen.getHeight(340))
                    //배경 밑에 20만큼 더 채우기위해
                    .padding(.bottom, UIScreen.getHeight(20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(firebaseSM.pawBackgroundColor, lineWidth: 4)
                    )
                    .background(firebaseSM.pawBackgroundColor)
                    .padding(.top, UIScreen.getHeight(20))
                    //본문 끝
                    
                    //댓글 리스트
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Rectangle()
                            .fill(firebaseSM.pawBackgroundColor)
                            .opacity(0.2)
                            .frame(width: UIScreen.getWidth(350), height: 1)
                        //댓글 스크롤
                        
                        ScrollView(showsIndicators: false) {
                            ForEach(firebaseSM.relatedComments , id: \.self.commentId) { comment in
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    //댓글 아이디
                                    Text(comment.userName)
                                        .customSubhead2()
                                        .foregroundColor(firebaseSM.pawForegroundColor)
                                        .padding(EdgeInsets(top: UIScreen.getHeight(16), leading: UIScreen.getWidth(20), bottom: 0, trailing:UIScreen.getWidth(20)))
                                    //댓글 내용
                                    Text(comment.content)
                                        .customSubhead4()
                                        .foregroundColor(firebaseSM.pawForegroundColor)
                                        .lineLimit(nil)
                                        .lineSpacing(2)
                                        .frame(width: UIScreen.getWidth(310), alignment: .leading)
                                        .padding(EdgeInsets(top: UIScreen.getHeight(6), leading: UIScreen.getWidth(20), bottom: 0, trailing:UIScreen.getWidth(20)))
                                    
                                    //마지막 구분선 삭제
                                    if comment.commentId != firebaseSM.relatedComments.last?.commentId {
                                        //댓글마다 구분선
                                        Rectangle()
                                            .fill(firebaseSM.pawBackgroundColor)
                                            .frame(width: UIScreen.getWidth(350), height: 1)
                                            .padding(.top, UIScreen.getHeight(16))
                                            .opacity(0.2)
                                    }
                                }
                                .padding(.top, -UIScreen.getHeight(8))
                            }
                            VStack {
                            }
                            .frame(height: UIScreen.getHeight(UIScreen.getHeight(110)))
                        }
                    }
                    .padding(.top, UIScreen.getHeight(20))
                }
                .padding(.top, UIScreen.getHeight(47))
                // 댓글입력
                
                VStack {
                    Spacer()
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color("CustomGray3"))
                            .frame(height: 1)
                        textInputView
                            .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(10), trailing: UIScreen.getWidth(20)))
                    }
                    .background(.white)
                    .onAppear( perform: UIApplication.shared.hideKeyboard)
                    .offset(y: isFocused ? -UIScreen.getHeight(250) : 0).animation(.easeInOut(duration: 0.2))
                    
                }
                .padding(.bottom, UIScreen.getHeight(34))
            }
            .ignoresSafeArea(.all)
//            .transition(.move(edge: .leading))
    }
    var backButton: some View {
        Button(action: {
            if status == "StoryView" {
                isCommentView.toggle()
            }
            else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            Image(systemName: "chevron.backward")
                .resizable()
                .frame(width: UIScreen.getWidth(10) ,height: UIScreen.getHeight(19))
                .foregroundColor(Color("MainColor"))
        }
    }
    
    //댓글 입력
    var textInputView: some View {
        
        HStack(alignment: .bottom) {
            
            //textfield 3줄만 보이고 스크롤 가능
            //iOS 16에서만 가능
            if #available(iOS 16.0, *) {
                TextField("", text: $text, axis: .vertical)
                    .placeholder(when: text.isEmpty) {
                        Text("댓글을 입력하세요.")
                            .customSubhead4()
                            .foregroundColor(Color("CustomGray2"))
                    }
                    .focused($isFocused)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .foregroundColor(firebaseSM.pawForegroundColor)
                    .font(.custom("AppleSDGothicNeo-Medium", size: 16))
                    .scrollIndicators(.hidden)
                    .lineSpacing(2)
                    .lineLimit(3)
            }
            //iOS15 이하 추후 업데이트 예정
            else {
            ZStack {
                TextView(placeholder: "",textColor: firebaseSM.pawForegroundColor, text: self.$text, minHeight: self.textHeight, calculatedHeight: self.$textHeight)
                    .focused($isFocused)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                    .padding(.top, -UIScreen.getHeight(6))
                    .padding(.bottom, -UIScreen.getHeight(6))
                
                if text.isEmpty {
                    HStack {
                        Text("댓글을 입력하세요.")
                            .customSubhead4()
                            .foregroundColor(Color("CustomGray2"))
                            .padding(.leading, 7)
                        Spacer()
                    }
                }
            }
            }
            //textfield 끝
            
            //서버연결 후 완성
            Button(action: {
                firebaseSM.uploadCommnet(storyId: firebaseSM.storyId, userName: "guest", content: text)
                text = ""
                isFocused = false
               
            }) {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: UIScreen.getWidth(19) ,height: UIScreen.getHeight(19))
                    .foregroundColor(firebaseSM.pawForegroundColor)
            }
            .disabled(text.isEmpty ? true : false)
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(10), trailing: UIScreen.getWidth(20)))
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke( firebaseSM.pawBackgroundColor == Color("pastelGreen") ? Color("pastelGreenOpacity0.2") : Color("pastelBlueOpacity0.2"), lineWidth: 1)
        )
        .background( firebaseSM.pawBackgroundColor == Color("pastelGreen") ? Color("pastelGreenOpacity0.2") : Color("pastelBlueOpacity0.2"))
    }
}
//
//struct CommnetView_Previews: PreviewProvider {
//    static var previews: some View {
//        // CreateStroyView()
//        CommnetView(post: constant().storySample, pawForegroundColor: Color("customGreen"), pawBackgroundColor: Color("pastelGreen"), otherFootPrintName: "catPaw")
//    }
//}

