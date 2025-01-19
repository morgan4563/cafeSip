//
//  HomeView.swift
//  cafeSip
//
//  Created by hyunMac on 12/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                Rectangle()
                    .fill(Color.brown)
                    .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                    .overlay() {
                        HStack {
                            Text("""
                            메인 뷰 배너
                            """)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            
                            Spacer()
                        }
                    }
                
                HStack {
                    Text("Quick Order")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Text("최근주문")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                .padding()
                
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.brown)
                        .frame(width: 280, height: 170)
                        .opacity(0.6)
                        .overlay {
                            Text("Quick Order")
                        }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
