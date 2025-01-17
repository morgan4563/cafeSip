//
//  AddressDetailView.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//

import SwiftUI

struct AddressDetailView: View {
    @Binding var storeRegisterViewModel: StoreRegisterViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("상세 주소 입력")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("상세 주소를 입력후 해당 주소로 설정을 통해 주소 등록을 마무리 해주세요.")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            Text(storeRegisterViewModel.address)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            TextField("상세 주소를 입력하세요", text: $storeRegisterViewModel.detailAddress)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray.opacity(0.5))
                .padding(.horizontal)
            
            Spacer()
   
            
            Button {
                navigationViewModel.goToStoreNameView()
            } label: {
                Text("해당 주소로 설정")
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
    AddressDetailView(storeRegisterViewModel: .constant(StoreRegisterViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
