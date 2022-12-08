//
//  ChilledCafeApp.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/10/19.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ChilledCafeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isFirst") private var isFirst: Bool = true
    @StateObject var firebaseSM: FirebaseStorageManager = FirebaseStorageManager()
    @State var isLoading: Bool = true
    @State var selectedTab: Int = 0
    @StateObject var viewRouter: ViewRouter = ViewRouter()
    
    
    var body: some Scene {
        WindowGroup {
            StoryView()
//            GeometryReader { geometry in
//                if isLoading {
//                    LaunchScreenView()
//                        .edgesIgnoringSafeArea(.all)
//                        .onAppear {
//                            let dispatchGroup = DispatchGroup()
//                            DispatchQueue.global().async(group: dispatchGroup) {
//                                dispatchGroup.enter()
//                                firebaseSM.getCafes(dispatchGroup: dispatchGroup)
//                            }
//                            dispatchGroup.notify(queue: DispatchQueue.main) {
//                                isLoading.toggle()
//                            }
//                        }
//                } else {
//                    NavigationView {
//                        if isFirst {
//                            IntroView()
//                        } else {
//                            VStack(spacing: 0) {
//                                switch viewRouter.currentPage {
//                                case .home:
//                                    MainView(firebaseSM: firebaseSM, ifFirst: true)
//                                case .bookmarked:
//                                    MyBookmarkView(firebaseSM: firebaseSM)
//                                }
//                                Spacer(minLength: 0)
//                                ZStack {
//                                    HStack {
//                                        // 홈
//                                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/3, height: geometry.size.height/28, iconName: "home")
//
//                                        // AR
//                                        NavigationLink(destination: ARMainView()) {
//                                            VStack {
//                                                Image("ar")
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .frame(width: geometry.size.width/3, height: geometry.size.height/28)
//                                                    .foregroundColor(.gray)
//                                            }
//                                        }
//
//                                        // 북마크
//                                        TabBarIcon(viewRouter: viewRouter, assignedPage: .bookmarked, width: geometry.size.width/3, height: geometry.size.height/28, iconName: "bookmarks")
//                                    }
//                                    .frame(width: geometry.size.width, height: geometry.size.height/14)
//                                    .overlay(Divider(), alignment: .top)
//                                }
//                                .padding(0)
//                            }
//                        }
//                    }
//                    .accentColor(Color("MainColor"))
//                }
//            }
        }
    }
}


