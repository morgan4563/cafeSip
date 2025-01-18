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
    var body: some View {
        VStack {
            Text("이미지")
            Spacer()
            Text("개인자산 : \(viewModel.balance)")
            
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
                        let processResult = await viewModel.processPayment(menu: menu)
                        if processResult {
                            navigationViewModel.goToOrderStatusView()
                        } else {
                            print("결제 실패 에러입니다.")
                        }
                    }
                } label: {
                    Text("결제하기")
                }
            } else {
                Text("메뉴가 선택되지 않았습니다")
            }
        }
    }
}



#Preview {
    MenuPaymentView(viewModel: .constant(OrderViewModel()), navigationViewModel: .constant(OrderNavigationViewModel()))
}
