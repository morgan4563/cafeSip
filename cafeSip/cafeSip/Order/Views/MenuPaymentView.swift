//
//  MenuPaymentView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct MenuPaymentView: View {
    @Binding var orderViewModel: OrderViewModel
    @Binding var navigationViewModel: OrderNavigationViewModel
    var body: some View {
        VStack {
            Text("이미지")
            Spacer()
            Text("개인자산 : \(orderViewModel.balance)")
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
                    Task {
                        await handlePayment(menu: menu)
                    }
                    orderViewModel.orderStatus = "preparing"
                    navigationViewModel.goToOrderStatusView()
                } label: {
                    Text("결제하기")
                }
            } else {
                Text("메뉴선택 안됨 에러")
            }
        }
    }
    func handlePayment(menu: MenuItem) async {
        guard let price = Int(menu.price) else {
            print("가격 변환 실패")
            return
        }
        let paymentSuccess = await orderViewModel.processPayment(price: price, ownerId: orderViewModel.ownerId)
        
                
        if paymentSuccess {
            let currentUser = AuthManager.shared.currentUser
            guard let currentUserId = currentUser?.id else { return }
            guard let currentUserName = currentUser?.userName else { return }
            
            let createOrderResult = orderViewModel.createOrder(menu: menu, customerId: currentUserId, customerName: currentUserName)
            
            guard let orderId = createOrderResult else { return }
            orderViewModel.orderId = orderId
            
        } else {
            print("결제 실패")
        }
    }
}



#Preview {
    MenuPaymentView(orderViewModel: .constant(OrderViewModel()), navigationViewModel: .constant(OrderNavigationViewModel()))
}
