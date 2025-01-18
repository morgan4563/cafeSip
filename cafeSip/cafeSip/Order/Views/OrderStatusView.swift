//
//  OrderStatusView.swift
//  cafeSip
//
//  Created by hyunMac on 1/17/25.
//

import SwiftUI

struct OrderStatusView: View {
    @Binding var orderViewModel: OrderViewModel
    @Binding var navigationViewModel: OrderNavigationViewModel
    
    var body: some View {
        VStack {
            if orderViewModel.orderStatus == "preparing" {
                Text("주문 준비 중입니다..")
                    .onAppear {
                        orderViewModel.observeStatus()
                    }
            } else if orderViewModel.orderStatus == "Ready"  {
                Text("주문이 준비되었습니다")
                    
            } else if orderViewModel.orderStatus == "Deleted" {
                Text("주문이 완료되었습니다")
                    .onAppear {
                        orderViewModel.stopOvserving()
                    }
                Button {
                    navigationViewModel.goToOrderView()
                } label: {
                    Text("첫 페이지로 돌아가기")
                }
            }
        }
        .onDisappear {
            orderViewModel.stopOvserving()
        }
    }
}

#Preview {
    OrderStatusView(orderViewModel: .constant(OrderViewModel()), navigationViewModel: .constant(OrderNavigationViewModel()))
}
