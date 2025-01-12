//
//  CompleteStoreRegistrationView.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//

import SwiftUI

struct CompleteStoreRegistrationView: View {
    @Binding var viewModel: AddressSelectionViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("매장 생성완료 뷰(임시)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            Text("매장 주소 : \(viewModel.address)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("매장 상세 주소 : \(viewModel.detailAddress)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("매장 이름 : \(viewModel.storeName)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
            Text("QR코드(임시)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
            Text("매장 등록완료 버튼")
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
    CompleteStoreRegistrationView(viewModel: .constant(AddressSelectionViewModel()))
}
