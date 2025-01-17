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
        VStack {
            Spacer()
            // 사진 업로드 추후 구현
            Image(systemName: "photo.artframe")
            Text("사진 업로드 추후 구현")

            Spacer()
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("메뉴명")
                TextField("메뉴명",text: $viewModel.newMenuName)
                Text("메뉴설명")
                TextField("메뉴설명",text: $viewModel.newMenuDescription)
                Text("가격")
                TextField("가격",text: $viewModel.newMenuPrice)
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                viewModel.addMenuItem()
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
    MenuRegistrationView(viewModel: .constant(StoreManagementViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
