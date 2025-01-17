//
//  CompleteStoreRegistrationView.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//

import SwiftUI

struct CompleteStoreRegistrationView: View {
    @Binding var storeRegisterViewModel: StoreRegisterViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("매장 생성 완료")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Text("\(storeRegisterViewModel.storeName)")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("""
                \(storeRegisterViewModel.address)
                \(storeRegisterViewModel.detailAddress)
                """)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            Spacer()
                
            Button {
                Task {
                    await StoreManager.shared.uploadStoreData(storeAddress: storeRegisterViewModel.address, storeDetailAddress: storeRegisterViewModel.detailAddress, storeName: storeRegisterViewModel.storeName, ownerId: AuthManager.shared.currentUser?.id ?? "")
                    
                    AuthManager.shared.currentUser?.storeId = StoreManager.shared.currentStore?.id
                }
                navigationViewModel.goToOtherView()
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
    CompleteStoreRegistrationView(storeRegisterViewModel: .constant(StoreRegisterViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
