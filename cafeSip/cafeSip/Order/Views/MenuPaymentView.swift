//
//  MenuPaymentView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct MenuPaymentView: View {
    @Binding var viewModel: OrderViewModel
    @Binding var navigationViewModel: OrderNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Text("이미지")
            Spacer()
            Divider()
            
            if let menu = viewModel.selectedMenu {
                Text(menu.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Text(menu.description)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                Text("가격: \(menu.price)원")
                    .font(.headline)
                    .padding()
                
                Button {
                    Task {
                        // 커런트 유저 정보 불러오는 기능 필요
                        let processResult = await viewModel.processPayment(menu: menu)
                        if processResult {
                            navigationViewModel.goToOrderStatusView()
                        } else {
                            print("결제 실패 에러입니다.")
                        }
                    }
                } label: {
                    Text("결제하기")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 363, height: 42)
                        .background(.brown)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            } else {
                Text("메뉴가 선택되지 않았습니다")
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
    MenuPaymentView(viewModel: .constant(OrderViewModel()), navigationViewModel: .constant(OrderNavigationViewModel()))
}
