//
//  OrderProcessingView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct OrderProcessingView: View {
    @Binding var viewModel: StoreManagementViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
//            Text(viewModel.storeName)
            Text("카페이름")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text("들어온 주문 보여주는곳")
                    Text("들어온 주문 보여주는곳")
                    Text("들어온 주문 보여주는곳")
                    Text("들어온 주문 보여주는곳")
                    Text("들어온 주문 보여주는곳")
                }
                .padding()
            }
            Spacer()
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
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    OrderProcessingView(viewModel: .constant(StoreManagementViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
