//
//  StoreRegisterView.swift
//  cafeSip
//
//  Created by hyunMac on 1/10/25.
//

import SwiftUI

struct StoreRegisterView: View {
    var body: some View {
        VStack {
            Text("매장 등록")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("영업중인 매장을 등록합니다. 지도를 통해서 주소확인후 해당 주소로 설정을 통해 상세 주소를 입력해 주세요.")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            
            Spacer()
   
            
            NavigationLink {
                AddressSelectionView()
            } label: {
                Text("해당 주소로 설정")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
        }
    }
}

#Preview {
    StoreRegisterView()
}
