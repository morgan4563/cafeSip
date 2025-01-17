//
//  StoreNameView.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//

import SwiftUI

struct StoreNameView: View {
    @Binding var storeRegisterViewModel: StoreRegisterViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
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
            
            TextField("매장 이름",text: $storeRegisterViewModel.storeName)
                .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray.opacity(0.5))
                .padding(.horizontal)
            
            Spacer()
            
            Button {
                navigationViewModel.goToCompleteStoreRegistrationView()
            } label: {
                Text("매장 등록 완료")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    StoreNameView(storeRegisterViewModel: .constant(StoreRegisterViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
