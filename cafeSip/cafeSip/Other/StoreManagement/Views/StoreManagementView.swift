//
//  StoreManagementView.swift
//  cafeSip
//
//  Created by hyunMac on 1/13/25.
//

import SwiftUI

struct StoreManagementView: View {
    @Binding var viewModel: StoreManagementViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text(viewModel.storeName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Button {
                navigationViewModel.goToMenuRegistrationView()
            } label: {
                Text("메뉴등록")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.menuItems) { menu in
                        HStack {
                            Text(menu.name)
                                .font(.headline)
                            Spacer()
                            Text(menu.description)
                            Spacer()
                            Text("\(menu.price)원")
                        }
                    }
                }
            }
            Spacer()
            
            Text("주문 알림 확인")
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
    StoreManagementView(viewModel: .constant(StoreManagementViewModel()),navigationViewModel: .constant(OtherNavigationViewModel()))
}
