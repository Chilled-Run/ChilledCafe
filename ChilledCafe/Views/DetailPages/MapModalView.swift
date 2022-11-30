//
//  MapModalView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/30.
//

import SwiftUI


import SwiftUI

struct HalfModalView<Content: View> : View {
    @GestureState private var dragState = DragState.inactive
    @Binding var isShown:Bool
    
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold = modalHeight * (2/3)
        if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold{
            isShown = false
        }
    }
    
    var modalHeight:CGFloat
    var content: () -> Content
    
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
        }
        .onEnded(onDragEnded)
        return Group {
            ZStack {
                //Background
                Spacer()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .background(isShown ? Color.black.opacity( 0.5 * fraction_progress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(dragState.translation.height), inverted: true)) : Color.clear)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                self.isShown = false
                        }
                )
                
                //Foreground
                VStack{
                    Spacer()
                    ZStack{
                        Color.white.opacity(1.0)
                            .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        // 모달에 들어갈 내용
                       
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("지도 앱 열기")
                                        .customHeadline()
                                    Spacer()
                                }
                                
                                HStack(spacing: UIScreen.getWidth(20)) {
                                    Button(action: {touchUpToConnectApp(mapKind: .naver)}){
                                        Image("naverMap")
                                            .resizable()
                                            .frame(width: UIScreen.getWidth(50),height: UIScreen.getHeight(50))
                                        Text("네이버 지도")
                                        Spacer()
                                    }
                                }
                                .padding(.top, UIScreen.getHeight(20))
                                
                                HStack(spacing: UIScreen.getWidth(20)) {
                                    Button(action: {touchUpToConnectApp(mapKind: .kakao)}){
                                        Image("kakao_map")
                                            .resizable()
                                            .frame(width: UIScreen.getWidth(50),height: UIScreen.getHeight(50))
                                        Text("카카오맵")
                                    }
                                }
                                .padding(.top, UIScreen.getHeight(10))
                                
                                HStack(spacing: UIScreen.getWidth(20)) {
                                    Button(action: {touchUpToConnectApp(mapKind: .google)}){
                                        Image("googleMap")
                                            .resizable()
                                            .frame(width: UIScreen.getWidth(50),height: UIScreen.getHeight(50))
                                        Text("구글맵")
                                    }
                                }
                                .padding(.top, UIScreen.getHeight(10))
                                Spacer()
                            }
                            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing: 0))
                            .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                            .clipped()
                    }
                    .offset(y: isShown ? ((self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : 0) : modalHeight)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(drag)
                    
                    
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

// 맵의 종류 별로 구분
enum mapKind {
    case kakao
    case google
    case naver
    
    var openURL: String {
        switch self {
        case .naver:
            return "nmap://place?lat=37.4979502&lng=127.0276368&name=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EC%84%B1%EB%82%A8%EC%8B%9C%20%EB%B6%84%EB%8B%B9%EA%B5%AC%20%EC%A0%95%EC%9E%90%EB%8F%99&appname=com.cookie.openURLTest:"
        case .kakao:
            return "kakaomap://look?p=37.537229,127.005515"
        case .google:
            return "comgooglemaps://?center=37.537229,127.005515&zoom=20"
        }
    }
}

//openURL을 사용해 map 앱과 연동
//추후 위도와 경도르 받아오는 작업 추가
func touchUpToConnectApp(mapKind: mapKind) {
        let kakaoTalk = mapKind.openURL
        let kakaoTalkURL = NSURL(string: kakaoTalk)
        
        if (UIApplication.shared.canOpenURL(kakaoTalkURL! as URL)) {
    
            UIApplication.shared.open(kakaoTalkURL! as URL)
        }
        else {
            print("No kakaotalk installed.")
        }
}

func fraction_progress(lowerLimit: Double = 0, upperLimit:Double, current:Double, inverted:Bool = false) -> Double{
    var val:Double = 0
    if current >= upperLimit {
        val = 1
    } else if current <= lowerLimit {
        val = 0
    } else {
        val = (current - lowerLimit)/(upperLimit - lowerLimit)
    }
    
    if inverted {
        return (1 - val)
        
    } else {
        return val
    }
    
}
