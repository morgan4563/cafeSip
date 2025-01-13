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
//            Text(viewModel.storeName)
            Text("힝힝카페")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("메뉴등록")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            Text("메뉴1")
            Text("메뉴2")
            Text("메뉴3")
            Text("메뉴4")
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
