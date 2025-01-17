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
            Text("매장 생성완료 뷰(임시)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            Text("매장 주소 : \(storeRegisterViewModel.address)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("매장 상세 주소 : \(storeRegisterViewModel.detailAddress)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("매장 이름 : \(storeRegisterViewModel.storeName)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
            Text("QR코드(임시)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
                
            Button("매장 등록 완료") {
                Task {
                    await StoreManager.shared.uploadStoreData(storeAddress: storeRegisterViewModel.address, storeDetailAddress: storeRegisterViewModel.detailAddress, storeName: storeRegisterViewModel.storeName, ownerId: AuthManager.shared.currentUser?.id ?? "")
                    
                    AuthManager.shared.currentUser?.storeId = StoreManager.shared.currentStore?.id
                }
                navigationViewModel.goToOtherView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
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
