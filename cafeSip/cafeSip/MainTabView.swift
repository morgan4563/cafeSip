//
//  MainTabView.swift
//  cafeSip
//
//  Created by hyunMac on 12/11/24.
//

import SwiftUI

struct MainTabView: View {
    @State var tabIndex = 0
    @State var payViewModel = PayViewModel()
    
    var body: some View {
        TabView(selection: $tabIndex) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)
            PayView(viewModel: $payViewModel)
                .tabItem {
                    Image(systemName: "creditcard.fill")
                }
                .tag(1)
            OrderView(payViewModel: $payViewModel)
                .tabItem {
                    Image(systemName: "mug.fill")
                }
                .tag(2)
            OtherView()
                .tabItem {
                    Image(systemName: "ellipsis")
                }
                .tag(3)
        }
    }
}

#Preview {
    MainTabView()
}
