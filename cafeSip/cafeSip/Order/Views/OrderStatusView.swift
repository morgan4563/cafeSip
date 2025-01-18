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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if orderViewModel.orderStatus == "preparing" {
                VStack {
                    Image(systemName: "figure.cooldown")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    Text("주문하신 메뉴가 준비 중입니다")
                }
                .onAppear {
                    orderViewModel.observeStatus()
                }
            } else if orderViewModel.orderStatus == "Ready"  {
                VStack {
                    Image(systemName: "figure.mixed.cardio")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    Text("주문하신 메뉴가 준비되었습니다")
                    Text("카운터에서 수령 해주세요")
                }
            } else if orderViewModel.orderStatus == "Deleted" {
                VStack {
                    Image(systemName: "figure.dance")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    Text("수령이 완료된 건입니다")
                    Button {
                        navigationViewModel.goToOrderView()
                    } label: {
                        Text("첫 페이지로 돌아가기")
                    }
                }
                .onAppear {
                    orderViewModel.stopOvserving()
                }
            }
        }
        .font(.headline)
        .fontWeight(.semibold)
        .onDisappear {
            orderViewModel.stopOvserving()
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
    OrderStatusView(orderViewModel: .constant(OrderViewModel()), navigationViewModel: .constant(OrderNavigationViewModel()))
}
