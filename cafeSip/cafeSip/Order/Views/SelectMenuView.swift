//
//  SelectMenuView.swift
//  cafeSip
//
//  Created by hyunMac on 1/15/25.
//

import SwiftUI

struct SelectMenuView: View {
    @Binding var viewModel: OrderViewModel
    @Binding var navigationViewModel: OrderNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text("Order")
                    .font(.title)
                    .fontWeight(.semibold)
                Text(viewModel.storeName)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.brown)
                    .opacity(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Rectangle()
                .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
                .foregroundStyle(.black).opacity(0.5)
            
            Text("전체 메뉴")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.menuItems) { menu in
                        VStack {
                            HStack {
                                Text(menu.name)
                                    .font(.headline)
                                Spacer()
                                Text(menu.description)
                                Spacer()
                                Text("\(menu.price)원")
                                Button {
                                    viewModel.selectedMenu = menu
                                    navigationViewModel.goToMenuPaymentView()
                                } label: {
                                    Text("선택")
                                        .padding()
                                        .background(.brown)
                                        .foregroundStyle(.white)
                                        .cornerRadius(8)
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .padding()
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
    SelectMenuView(viewModel: .constant(OrderViewModel()), navigationViewModel: .constant(OrderNavigationViewModel()))
}
