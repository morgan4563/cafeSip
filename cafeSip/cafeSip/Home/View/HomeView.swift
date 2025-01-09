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
                //- 메인이미지 시작
                Image("snowImage")
                    .resizable()
                    .scaledToFit()
                
                // 이미지 색상조절 오버레이
                    .overlay() {
                        Color.black.opacity(0.15)
                    }
                
                // 텍스트 오버레이
                    .overlay() {
                        HStack {
                            Text("""
                            메인에 삽입될 글씨
                            구간입니다
                            """)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            
                            Spacer()
                        }
                    }
                //- 메인이미지 끝
                
                //- 퀵오더 시작
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
                //- 퀵오더 끝
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
