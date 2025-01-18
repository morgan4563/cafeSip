//
//  cafeSipApp.swift
//  cafeSip
//
//  Created by hyunMac on 12/11/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct cafeSipApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { oldPhase , newPhase in
            switch newPhase {
            case .active:
                print("앱 활성상태")
            case .inactive:
                print("앱 비활성화 상태")
            case .background:
                print("앱 백그라운드 전환 상태")
                AuthManager.shared.saveCurrentUserDataOnBackground()
            default:
                break
            }
        }
    }
}
