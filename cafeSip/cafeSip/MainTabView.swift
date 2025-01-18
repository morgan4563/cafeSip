//
//  MainTabView.swift
//  cafeSip
//
//  Created by hyunMac on 12/11/24.
//

import SwiftUI

struct MainTabView: View {
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
                .tag(0)
            PayView()
                .tabItem {
                    VStack {
                        Image(systemName: "creditcard.fill")
                        Text("Pay")
                    }
                    
                }
                .tag(1)
            OrderView()
                .tabItem {
                    VStack {
                        Image(systemName: "mug.fill")
                        Text("Order")
                    }
                    
                }
                .tag(2)
            OtherView()
                .tabItem {
                    VStack {
                        Image(systemName: "ellipsis")
                        Text("Other")
                    }
                }
                .tag(3)
        }.accentColor(.brown)
    }
}

#Preview {
    MainTabView()
}
