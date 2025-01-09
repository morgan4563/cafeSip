//
//  ContentView.swift
//  cafeSip
//
//  Created by hyunMac on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var loginViewModel = LoginViewModel()
    
    var body: some View {
        if AuthManager.shared.currentUser == nil {
            LoginView(loginViewModel: $loginViewModel)
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
