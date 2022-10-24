//
//  CafeDetailView.swift
//  ChilledCafe
//
//  Created by 심규보 on 2022/10/24.
//

import SwiftUI

struct CafeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // Max Height...
    let maxWidth = UIScreen.main.bounds.width
    let maxHeight = UIScreen.main.bounds.height
    
    var topEdge: CGFloat
    
    // Offset
    @State var offset: CGFloat = 0
    @State var currentTab: Int = 0
    @State var tabIndex: Int = 0
    @State var currentType: String = "Mood"
    
    let tabBarElements: [String] = ["Mood", "Menu", "Info"]
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    // MARK: For Smooth Sliding Effect
    @Namespace var animation
    @Namespace var namespace
    
    let cafe: Cafe
    
    var body: some View {
        NavigationView{
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {

                    VStack(spacing: 15) {

                        // Top Nav View
                        GeometryReader { geo in
                            Background(cafe: cafe, offset: $offset)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color.white)
                            // Sticky effect
                                .frame(width: maxWidth, height: getHeaderHeight(), alignment: .bottom)
                                .overlay(
                                    // Top Nav View
                                    HStack(spacing: 15) {
                                        // Go back
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Image(systemName: "chevron.backward")
                                                .foregroundColor(.blue)
                                        }
                                        .padding(.leading, 20)
                                        .padding(.top, 25)
                                        .opacity(topBarTitleOpacity())

                                        Spacer()

                                        // Cafe Title
                                        Text(cafe.name)
                                            .padding(.top, 25)
                                            .foregroundColor(.blue)
                                            .opacity(topBarTitleOpacity())

                                        Spacer()

                                        // Heart Button
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(.blue)
                                        }
                                        .padding(.top, 25)
                                        .padding(.trailing, 20)
                                        .opacity(topBarTitleOpacity())


                                    }
                                    // .padding(.trailing)
                                        .background(Color.clear)
                                        .frame(height: 80)
                                        .padding(.top, topEdge)

                                    ,alignment: .top
                                )

                        }
                        .frame(height: maxHeight)

                        // Fixing at top..
                        .offset(y: -offset)
                        .zIndex(1)

                        //++++++++++++++++++++++++++++++++++++++++++++

                        LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                            Section {
                                Spacer()
                                VStack {
                                    TabView(selection: $currentType) {
                                        Mood(cafe: cafe).tag("Mood")
                                        Menu(cafe: cafe).tag("Menu")
                                        Info(cafe: cafe).tag("Info")
                                    }
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



//                            LazyVStack(pinnedViews: [.sectionHeaders]) {
//                                Section {
//                                    if currentType == "Mood" {
//                                        Mood()
//                                        .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
////                                        SampleContents()
////                                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
//                                    }
//                                    else if currentType == "Menu" {
//                                        Menu()
//                                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
//                                    }
//                                    else {
//                                        Info()
//                                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
//                                    }
//                                }
//                                header: {
//                                    PinnedHeaderView()
//                                        .background(Color.white)
//                                        .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 7)
//                                        .modifier(OffsetModifier2(offset: $headerOffsets.0, returnFromStart: false))
//                                        .modifier(OffsetModifier2(offset: $headerOffsets.1))
//                                }
//                            }
                            .padding(.bottom)



                        //++++++++++++++++++++++++++++++++++++++++++++

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
            
            // setting coordinate space
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    // MARK: Pinned Header
    
    @ViewBuilder
    func PinnedHeaderView() -> some View {
        // ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
        
                    ForEach(tabBarElements, id: \.self) { type in
                        VStack(spacing: 12) {
        
                            Text(type)
                                .fontWeight(.semibold)
                                .foregroundColor(currentType == type ? .black : .gray)
        
                            ZStack {
                                if currentType == type {
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                                else {
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .fill(.clear)
                                }
                            }
                            .padding(.horizontal, 8)
                            .frame(height: 4)
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
    
    // MARK: Pinned Content
    
    @ViewBuilder
    func SampleContents() -> some View {
        VStack(spacing: 15) {
//            Spacer()
//            TabView(selection: $currentType) {
//                Mood().tag("Mood")
//                Menu().tag("Menu")
//                Info().tag("Info")
//            }
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
    
    func getHeaderHeight() -> CGFloat {
        let topHeight: CGFloat = maxHeight + offset
        
        // 80 is the constant top Nav bar height
        // since we included top safe area so we also need to include that too..
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    
    func topBarTitleOpacity() -> CGFloat {
        // to start after the main content vanished..
        // we need to eliminate 500 from offset...
        
        let progress = -(offset + 40) / (maxHeight - (80 + topEdge))
        
        return progress
    }
    
    func getOpacity() -> CGFloat {
        
        // 70 = Some random amount of time to visible on scroll...
        let progress = -offset / 750
        
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
}



// MARK: Moving Background

struct Background: View {
    @State var cafe: Cafe
    @Binding var offset: CGFloat
    
    var body: some View {
        ZStack {
            Image("map")
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading){
                Spacer()
                Text(cafe.name)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Text(cafe.shortIntroduction)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom, 50)
            }
            
        }
        .opacity(getOpacity())
    }
    
    func getOpacity() -> CGFloat {
        
        // 70 = Some random amount of time to visible on scroll...
        let progress = -offset / 850
        
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
}

// MARK: Go back with gesture

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

//struct CafeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CafeDetailView()
//    }
//}
