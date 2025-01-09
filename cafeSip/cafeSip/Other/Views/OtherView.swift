//
//  OtherView.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import SwiftUI

struct OtherView: View {
    var body: some View {
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
                Button {
                    print("매장 등록")
                } label: {
                    Text("매장 등록하기")
                }

            }
            
            
            
            Spacer()
        }
    }
}


#Preview {
    OtherView()
}
