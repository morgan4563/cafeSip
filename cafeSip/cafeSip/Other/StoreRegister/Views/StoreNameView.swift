//
//  StoreNameView.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//

import SwiftUI

struct StoreNameView: View {
    @Binding var viewModel: AddressSelectionViewModel
    var body: some View {
        VStack {
            Text("매장 이름")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("매장의 이름을 설정해주세요")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            TextField("매장 이름",text: $viewModel.storeName)
                .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray.opacity(0.5))
                .padding(.horizontal)
            
            Spacer()
            
            NavigationLink {
                // 매장 등록 완료 화면으로 이동
            } label: {
                Text("매장 등록 완료")
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
    StoreNameView(viewModel: .constant(AddressSelectionViewModel()))
}
