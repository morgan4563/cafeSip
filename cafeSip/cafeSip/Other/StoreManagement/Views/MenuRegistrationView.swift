//
//  MenuRegistrationView.swift
//  cafeSip
//
//  Created by hyunMac on 1/14/25.
//

import SwiftUI

struct MenuRegistrationView: View {
    @Binding var storeManagementViewModel: StoreManagementViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            // 사진 업로드 추후 구현
            Image(systemName: "photo.artframe")
            Text("사진 업로드 추후 구현")

            Spacer()
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("메뉴명")
                TextField("메뉴명",text: $storeManagementViewModel.newMenuName)
                Text("메뉴설명")
                TextField("메뉴설명",text: $storeManagementViewModel.newMenuDescription)
                Text("가격")
                TextField("가격",text: $storeManagementViewModel.newMenuPrice)
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                guard let storeId = StoreManager.shared.currentStore?.id else {
                    print("currentStoreId 존재하지않음")
                    return
                }
                storeManagementViewModel.addMenuItem(storeId: storeId)
                dismiss()
            } label: {
                Text("메뉴등록")
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
    MenuRegistrationView(storeManagementViewModel: .constant(StoreManagementViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
