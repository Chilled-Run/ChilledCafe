//
//  VisitPostView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/02.
//

import SwiftUI

struct StoryView: View {
    @Binding var isPopup: Bool
    @Binding var otherFootPrintName: String
    //임시로 만든 게시글 데이터
    var post = constant().storySample
    //게시글의 글자색
    var pawForegroundColor: Color {
        getForegroundColor(foot: otherFootPrintName)
    }
    //게시글의 배경색
    var pawBackgroundColor: Color {
        getBackgroundColor(foot: otherFootPrintName)
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                    .opacity(0.8)
                    .navigationBarHidden(true)
                if isPopup {
                    VStack {
                        // 취소 버튼
                        HStack {
                            Spacer()
                            backButton
                        }
                        .padding(.bottom, UIScreen.getHeight(20))
                        .padding(.trailing, UIScreen.getHeight(30))
                        
                        // 게시글
                        VStack(alignment: .leading, spacing: 0) {
                            
                            //본문
                            StoryContetView(post: post, pawForegroundColor: pawForegroundColor, pawBackgroundColor: pawBackgroundColor, otherFootPrintName: otherFootPrintName)
                            
                            // 구분선
                            Rectangle()
                                .fill(pawForegroundColor)
                                .frame(height: 1)
                                .padding(.top, UIScreen.getHeight(10))
                            
                            //전체 댓글 페이지로 이동
                            NavigationLink(destination: CommnetView(post: post, pawForegroundColor: pawForegroundColor, pawBackgroundColor: pawBackgroundColor, otherFootPrintName: otherFootPrintName)) {
                                //댓글 문단, 댓글의 아이디, 내용이 보이는 곳
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(post.comments[0].userName)
                                        .foregroundColor(pawForegroundColor)
                                        .customSubhead2()
                                    
                                    Text(post.comments[0].context)
                                        .foregroundColor(Color.white)
                                        .customSubhead4()
                                }
                                .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(30), bottom: UIScreen.getHeight(20), trailing:UIScreen.getWidth(30)))
                            }
                        }
                        .frame(width: UIScreen.getWidth(340), height: UIScreen.getHeight(420))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(pawBackgroundColor, lineWidth: 2)
                        )
                        .background(pawBackgroundColor)
                        
                        Spacer()
                    }
                    .padding(.top, UIScreen.getHeight(117))
                }
            }
            .padding(.top, 0)
        }.padding(.top, 0)
        
    }
    
    //취소 버튼
    var backButton : some View {
        Button(action: {
            isPopup.toggle()
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

// TODO: 추후 extension으로 리팩필요
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

