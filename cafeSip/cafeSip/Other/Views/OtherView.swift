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
            VStack {
                HStack {
                    Text("Other")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .padding()
                    
                    Spacer()
                }
                
                Divider()
                
                HStack {
                    Text("매장 관리")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                
                HStack {
                    NavigationLink {
                        AddressSelectionView()
                    } label: {
                        Text("주소로 매장 설정하기")
                    }
                }
                
                Spacer()
            }
        }
    }
}


#Preview {
    OtherView()
}
