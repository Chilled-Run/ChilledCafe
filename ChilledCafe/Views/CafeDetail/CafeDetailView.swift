//
//  CafeDetailView.swift
//  ChilledCafe
//
//  Created by 심규보 on 2022/10/24.
//

import SwiftUI
import UIKit
import Kingfisher

struct CafeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let maxWidth = UIScreen.main.bounds.width
    let maxHeight = UIScreen.main.bounds.height
    
    var topEdge: CGFloat
    
    // Offset
    @State var offset: CGFloat = 0
    @State var currentTab: Int = 0
    @State var tabIndex: Int = 0
    @State var currentType: String = "Mood"
    @State var isLiked = false
    
    let tabBarElements: [String] = ["Mood", "Menu", "Info"]
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    // MARK: For Smooth Sliding Effect
    @Namespace var animation
    @Namespace var namespace
    
    let cafe: Cafe
    
    var body: some View {
        VStack{
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        // Top Nav View
                        GeometryReader { geo in
                            Background(cafe: cafe, offset: $offset)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color.white)
                            // 드래그시 사진이 늘어나게끔 프레임 설정
                                .frame(width: maxWidth, height: getHeaderHeight(), alignment: .bottom)
                            
                            // MARK: 상단 사라지는 메뉴 바
                            
                                .overlay(
                                    HStack(spacing: 15) {
                                        
                                        // 뒤로가기 버튼
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Image(systemName: "chevron.backward")
                                                .foregroundColor(.black)
                                            
                                        }
                                        .padding(.leading, 20)
                                        .padding(.top, 25)
                                        .opacity(topBarTitleOpacity())
                                        
                                        Spacer()
                                        
                                        // 카페명
                                        Text(cafe.name)
                                            .customTitle2()
                                            .padding(.top, 25)
                                            .foregroundColor(.black)
                                            .opacity(topBarTitleOpacity())
                                        
                                        Spacer()
                                        
                                        // 좋아요 버튼
                                        Button(action: {
                                            
                                        }) {
                                            Image(systemName: "heart")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.top, 25)
                                        .padding(.trailing, 20)
                                        .opacity(topBarTitleOpacity())
                                        
                                        
                                    }
                                        .background(Color.clear)
                                        .frame(height: 80)
                                        .padding(.top, topEdge)
                                    
                                    ,alignment: .top
                                )
                            
                        }
                        .frame(height: maxHeight)
                        
                        // 상단에 offset 고정
                        .offset(y: -offset)
                        .zIndex(1)
                        
                        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        // MARK: 메인 탭뷰
                        
                        LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                            Section {
                                Spacer()
                                VStack {
                                    //                                    TabView(selection: $currentType) {
                                    if currentType == "Mood"{
                                        Mood(cafe: cafe)
                                    }
                                    else if currentType == "Menu" {
                                        Menu(cafe: cafe)
                                    }
                                    else {
                                        Info()
                                    }
                                        // Mood(cafe: cafe).tag("Mood")
//                                        Menu(cafe: cafe).tag("Menu")
//                                        Info().tag("Info")
//                                    }
                                }
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .frame(maxWidth: .infinity, minHeight: proxy.size.height)
                                .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                                
                            } header: {
                                PinnedHeaderView()
                                    .background(Color.white)
                                    .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                                    .modifier(OffsetModifier2(offset: $headerOffsets.0, returnFromStart: false))
                                    .modifier(OffsetModifier2(offset: $headerOffsets.1))
                                
                            }
                        }
                        .padding(.bottom)
                        
                        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    }
                    .modifier(OffsetModifier(offset: $offset))
                }
                .coordinateSpace(name: "SCROLL")
                .edgesIgnoringSafeArea(.top)
                .overlay(content: {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 80)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .opacity(headerOffsets.0 < 20 ? 1 : 0)
                })
            }
            .ignoresSafeArea(.all)
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    // MARK: 스티키 헤더를 위한 메뉴 선택 바
    
    @ViewBuilder
    func PinnedHeaderView() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .foregroundColor(Color("CustomGray3"))
                .frame(height: 2)
                .padding(.horizontal)
                .padding(.top, 50)
            HStack(spacing: 25) {
                
                ForEach(tabBarElements, id: \.self) { type in
                    VStack(spacing: 12) {
                        
                        Text(type)
                            .CustomDesignedBody()
                            .foregroundColor(currentType == type ? Color("MainColor") : Color("CustomGray2"))
                        
                        
                        ZStack {
                            if currentType == type {
                                RoundedRectangle(cornerRadius: 1, style: .continuous)
                                    .fill(Color("MainColor"))
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                            else {
                                RoundedRectangle(cornerRadius: 1, style: .continuous)
                                    .fill(.clear)
                            }
                        }
                        .frame(height: 2)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            currentType = type
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 25)
            .padding(.bottom, 5)
        }
        .padding(.bottom, 20)
        
    }
    
    // MARK: 상단 헤더의 높이를 가져옴
    
    func getHeaderHeight() -> CGFloat {
        let topHeight: CGFloat = maxHeight + offset
        
        // 80 is the constant top Nav bar height
        // since we included top safe area so we also need to include that too..
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    
    // MARK: 메인 화면을 내리면서 상단바를 보이게끔 opacity 조정
    
    func topBarTitleOpacity() -> CGFloat {
        let progress = -(offset + 40) / (maxHeight - (80 + topEdge))
        
        return progress
    }
    
    // MARK: 스크롤을 내릴때 offset에 따라서 opacity를 변경합니다.
    
    func getOpacity() -> CGFloat {
        
        // 아래 숫자를 조정하면서 얼마나 빠르게 또는 느리게 사라지게할지 조정 가능
        let progress = -offset / 750
        
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
    
    // MARK: 테스트용 샘플 컨텐츠
    
    @ViewBuilder
    func SampleContents() -> some View {
        VStack(spacing: 15) {
            
            Spacer()
            ForEach(0 ..< 10) { num in
                Text("참깨빵위에")
                Text("순쇠고기 패티 두장")
                Text("특별한 소스")
                Text("양상추")
                Text("치즈 피클")
                Text("양파까지")
                Text("빠바바바빰")
            }
        }
    }
}



// MARK: GIF 화면

struct Background: View {
    @State var cafe: Cafe
    @State var isLiked = false
    @Binding var offset: CGFloat
    
    var body: some View {
            ZStack {
                KFAnimatedImage(URL(string: cafe.gif))
                    .aspectRatio(contentMode: .fill)
                Image("gradientBox")
                    .resizable()
                
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(cafe.name)
                            .customLargeTitle()
                            .foregroundColor(.white)
                            .padding(.leading, 25)
                            .padding(.bottom, 5)
                        Text(cafe.shortIntroduction)
                            .customHeadline()
                            .foregroundColor(.white)
                            .padding(.leading, 25)
                            .padding(.bottom, 24)
                        Image(systemName: "chevron.compact.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 36)
                            .foregroundColor(.white)
                            .padding(.horizontal, (UIScreen.main.bounds.width / 2) - 18)
                            .padding(.bottom, 24)
                    }   // .. end VStack

                    Spacer()
                }   // ..end HStack
                .frame(width: UIScreen.main.bounds.width)
                
            }   // .. end ZStack
            .frame(width: UIScreen.main.bounds.width)
            .opacity(getOpacity())
    }
    
    
    func getOpacity() -> CGFloat {
        // 아래 숫자를 조정하면서 얼마나 빠르게 또는 느리게 사라지게할지 조정 가능
        let progress = -offset / 850
        
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
}


// MARK: 뒤로가기 제스쳐 확장

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

