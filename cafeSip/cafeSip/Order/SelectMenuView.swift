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
        VStack(alignment: .leading) {
            Text("Order")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .padding()
            
            Divider()
            
            Text("전체 메뉴")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
            
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
                        .padding()
                    }
                }
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
