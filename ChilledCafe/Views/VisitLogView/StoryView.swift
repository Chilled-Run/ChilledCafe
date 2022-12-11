//
//  VisitPostView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/02.
//

import SwiftUI

struct StoryView: View {
    @Binding var arMainViewState: ARMainViewState
    @Binding var otherFootPrintName: String
    //
    // forTest
    @ObservedObject var firebaseSM: FirebaseStorageManager
    @Binding var isStepped: Bool
    @State var storyId = ""
    @State var isCommentView = false
    @State var isToggleLike = false
    
    var footNumber = ["leftFoot": 0, "rightFoot" : 1, "catFoot" : 2]
    var afterFootNumber = ["leftFoot": 1, "rightFoot" : 2, "catFoot" : 3]
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .navigationBarHidden(true)
            VStack {
                // 취소 버튼
                HStack {
                    Spacer()
                    backButton
                }
                .padding(.bottom, UIScreen.getHeight(20))
                .padding(.trailing, UIScreen.getHeight(30))
                //forTest
                .onAppear() {
                    firebaseSM.getFirstStroy()
                    if isStepped  {
                        //자신의 스토리 업로드 후
                        storyId = firebaseSM.getStoryId(index: afterFootNumber[otherFootPrintName] ?? 0)
                        print(otherFootPrintName)
                        print(afterFootNumber[otherFootPrintName] ?? 0)
                    }
                    else {
                        //자신의 스토리 업로드 전
                        storyId = firebaseSM.getStoryId(index: footNumber[otherFootPrintName] ?? 0)
                        print(otherFootPrintName)
                    }
                    firebaseSM.fetchRelatedComment(storyId: storyId)
                }
                
                
                // 게시글
                VStack(alignment: .leading, spacing: 0) {
                    //본문
                    StoryContentView(firebaseSM: firebaseSM)
                    
                    //세번째 문단, 좋아요, 댓글의 개수가 보이는 곳
                    //네비게이션을 사용하기 위해 StoryContentView와 분리
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
                        .onTapGesture {
                            isCommentView.toggle()
                        }
                        Spacer()
                    }
                    .foregroundColor(firebaseSM.pawForegroundColor)
                    .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(30), bottom: UIScreen.getHeight(20), trailing:UIScreen.getWidth(30)))
                    // 구분선
                    Rectangle()
                        .fill(firebaseSM.pawForegroundColor)
                        .frame(height: 1)
                        .padding(.top, UIScreen.getHeight(10))
                    
                    
                    //댓글 문단, 댓글의 아이디, 내용이 보이는 곳
                    //댓글이 있어야 보여줌
                    if !firebaseSM.relatedComments.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(firebaseSM.relatedComments[0].userName)
                                .foregroundColor(firebaseSM.pawForegroundColor)
                                .customSubhead2()
                            
                            Text(firebaseSM.relatedComments[0].content)
                                .foregroundColor(Color.white)
                                .customSubhead4()
                        }
                        .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(30), bottom: UIScreen.getHeight(20), trailing:UIScreen.getWidth(30)))
                        .onTapGesture(){
                            isCommentView.toggle()
                        }
                    }
                }
                .frame(width: UIScreen.getWidth(340), height: UIScreen.getHeight(420))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(firebaseSM.pawBackgroundColor, lineWidth: 2)
                )
                .background(firebaseSM.pawBackgroundColor)
                
                Spacer()
            }
            .padding(.top, UIScreen.getHeight(57))
            // CommentView로 이동
            if isCommentView {
                CommnetView(firebaseSM: firebaseSM, storyId: firebaseSM.storyId)
                    .padding(.top, 0)
            }
        }
        .padding(.top, 0)
    }
    
    //취소 버튼
    var backButton : some View {
        Button(action: {
            self.arMainViewState = .afterFloorDetected
        }) {
            ZStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color("CustomGray3"))
                    .frame(width: UIScreen.getWidth(40) ,height: UIScreen.getHeight(40))
            }
        }
    }
}

//struct VisitPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryView()
//    }
//}

// TODO: 추후 리팩필요
//발자국 종류에 따른 색 변경
func getForegroundColor(foot: String) -> Color {
    switch foot {
            //return mainColor
        case "leftFoot":
            return Color("MainColor")
        case "bearPaw":
            return Color("MainColor")
        case "birdFoot":
            return Color("MainColor")
        case "rightFoot":
            return Color("MainColor")
            
            //return CustomGreen
        case "catPaw":
            return Color("customGreen")
        case "dogFoot":
            return Color("customGreen")
        case "duckFoot":
            return Color("customGreen")
            //horsePaw
        default:
            return Color("customGreen")
    }
}

func getBackgroundColor(foot: String) -> Color {
    switch foot {
            //return pastelBlue
        case "leftFoot":
            return Color("pastelBlue")
        case "bearPaw":
            return Color("pastelBlue")
        case "birdFoot":
            return Color("pastelBlue")
        case "rightFoot":
            return Color("pastelBlue")
            
            //return pastelGreen
        case "catPaw":
            return Color("pastelGreen")
        case "dogFoot":
            return Color("pastelGreen")
        case "duckFoot":
            return Color("pastelGreen")
            //horsePaw
        default:
            return Color("pastelGreen")
    }
}

