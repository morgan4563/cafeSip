//
//  MenuRegistrationView.swift
//  cafeSip
//
//  Created by hyunMac on 1/14/25.
//

import SwiftUI

struct MenuRegistrationView: View {
    @Binding var viewModel: StoreManagementViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // 사진 업로드 추후 구현
        VStack {
            Spacer()
            Text("사진")
            Spacer()
            Text("메뉴명")
            TextField("메뉴명",text: $viewModel.newMenuName)
            Text("메뉴설명")
            TextField("메뉴설명",text: $viewModel.newMenuDescription)
            Text("가격")
            TextField("가격",text: $viewModel.newMenuPrice)
            Spacer()
            Button {
                viewModel.addMenuItem()
                navigationViewModel.goToStoreManagementView()
            } label: {
                Text("메뉴등록")
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
    MenuRegistrationView(viewModel: .constant(StoreManagementViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
