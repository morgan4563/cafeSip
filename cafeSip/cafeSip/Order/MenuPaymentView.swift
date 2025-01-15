//
//  MenuPaymentView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct MenuPaymentView: View {
    @Binding var orderViewModel: OrderViewModel
    @Binding var payViewModel: PayViewModel
    @Binding var navigationViewModel: OrderNavigationViewModel
    var body: some View {
        VStack {
            Text("이미지")
            Spacer()
            Text("개인자산 : \(payViewModel.balance)")
            if let menu = orderViewModel.selectedMenu {
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
                    if payViewModel.balance >= Int(menu.price)! {
                        payViewModel.balance -= Int(menu.price)!
                        print("주문완료")
                    } else {
                        print("잔액부족")
                    }
                } label: {
                    Text("결제하기")
                }
            } else {
                Text("메뉴선택 안됨 에러")
            }
        }
    }
}

#Preview {
    MenuPaymentView(orderViewModel: .constant(OrderViewModel()), payViewModel: .constant(PayViewModel()), navigationViewModel: .constant(OrderNavigationViewModel()))
}
