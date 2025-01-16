//
//  ContentView.swift
//  cafeSip
//
//  Created by hyunMac on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if AuthManager.shared.currentUser == nil {
            LoginView()
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
