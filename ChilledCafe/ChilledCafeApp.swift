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
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isFirst {
                    IntroView()
                } else {
                    MainView(firebaseSM: firebaseSM, ifFirst: true)
                }
            }
            .accentColor(Color("MainColor"))
        }
    }
}
