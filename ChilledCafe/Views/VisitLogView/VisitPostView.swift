//
//  VisitPostView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/02.
//

import SwiftUI

struct VisitPostView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                //첫번째 문단
                HStack {
                    VStack(alignment: .leading) {
                        Text("12번째 방문한")
                        Text("아이디")
                        Text("2022.11.17 다녀감")
                    }
                    Spacer()
                    Image("bearPaw")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                //두번째 문단
                VStack(alignment: .leading) {
                    Text("사장님,")
                    Text("딸기 말고 다른 맛은")
                    Text("만드실 생각")
                    Text("없으신지요?")
                }
                //세번째 문단
                Spacer()
                HStack {
                    Image(systemName: "heart")
                    Text("999+")
                    Image(systemName: "message")
                    Text("999+")
                    Spacer()
                }
                
                // 구분선
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)

                //댓글 문단
                    VStack(alignment: .leading) {
                        Text("아이디")
                        Text("어떤걸로 해드릴까요")
                    }
            }
            .padding(EdgeInsets(top: 30, leading: 30, bottom: 20, trailing:30))
        }
        .frame(width: 340, height: 420)
        .background(Color.orange)
    }
}

struct VisitPostView_Previews: PreviewProvider {
    static var previews: some View {
        VisitPostView()
    }
}
