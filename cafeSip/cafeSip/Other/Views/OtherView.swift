//
//  OtherView.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import SwiftUI

struct OtherView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Other")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .padding()
                
                Divider()
                
                Text("매장 관리")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 4)
                
                
                NavigationLink {
                    AddressSelectionView()
                } label: {
                    HStack {
                        Image(systemName: "house.circle.fill")
                        Text("매장 등록하기")
                    }
                    .padding(.horizontal, 16)
                    .foregroundStyle(.black)
                    .opacity(0.8)
                }
                
                
                Spacer()
            }
            
            Spacer()
        }
    }
}


#Preview {
    OtherView()
}
