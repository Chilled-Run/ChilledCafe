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
            GeometryReader { geometry in
                if isLoading {
                    LaunchScreenView()
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            // forTest
                            let dispatchGroup = DispatchGroup()
                            DispatchQueue.global().async(group: dispatchGroup) {
                                dispatchGroup.enter()
                                firebaseSM.getCafes(dispatchGroup: dispatchGroup)
                                firebaseSM.fetchPost()
                                firebaseSM.fetchComment()
                            }
                            dispatchGroup.notify(queue: DispatchQueue.main) {
                                isLoading.toggle()
                        }
                    }
                } else {
                    NavigationView {
                        if isFirst {
                            IntroView()
                        } else {
                            VStack(spacing: 0) {
                                switch viewRouter.currentPage {
                                case .home:
                                    MainView(firebaseSM: firebaseSM, ifFirst: true)
                                case .bookmarked:
                                    MyBookmarkView(firebaseSM: firebaseSM)
                                }
                                // Tab
                                ZStack(alignment: .top) {
                                    Color.white
                                    Divider()
                                    HStack {
                                        // 홈

                                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/1.8, height: geometry.size.height/28, iconName: "home")
                                        // 북마크
                                        TabBarIcon(viewRouter: viewRouter, assignedPage: .bookmarked, width: geometry.size.width/1.8, height: geometry.size.height/28, iconName: "bookmarks")

                                    }
                                    .frame(width: geometry.size.width, height: geometry.size.height/18)
                                    .padding(0)

                                    // AR
                                    ZStack {
                                        Circle()
                                            .foregroundColor(.white)
                                            .frame(width: geometry.size.width/4.8, height: geometry.size.width/4.8)

                                        Circle()
                                            .foregroundColor(Color("MainColor"))
                                            .frame(width: geometry.size.width/5.5, height: geometry.size.width/5.5)

                                        NavigationLink(destination: ARMainView(firebaseSM: firebaseSM)) {
                                            VStack {
                                                Image("ar")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: geometry.size.width/3, height: geometry.size.height/24)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                    .offset(y: -geometry.size.height/28/2)
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height/18)
                                .offset(y: geometry.size.height/28/2)
                            }
                        }
                    }
                    .accentColor(Color("MainColor"))
                }
            }
        }
    }
}


