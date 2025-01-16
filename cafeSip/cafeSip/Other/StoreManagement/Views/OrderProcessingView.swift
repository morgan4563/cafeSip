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
    @State var completedOrders: Set<String> = []
    
    var body: some View {
        VStack {
//            Text(viewModel.storeName)
            Text("카페이름")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.orders) { order in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("주문자 : \(order.customerName)")
                            Text("메뉴 ID : \(order.menuId)")
                            Text("가격 : \(order.price)원")
                            Text("주문 시간 : \(order.orderTime, style: .time)")
                            if completedOrders.contains(order.id) {
                                Button() {
                                    viewModel.deleteOrder(orderId: order.id)
                                } label: {
                                    Text("주문삭제")
                                        .foregroundStyle(.red)
                                }
                            } else {
                                Button() {
                                    viewModel.updateOrderStatus(orderId: order.id)
                                    completedOrders.insert(order.id)
                                } label: {
                                    Text("주문완료")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                    }
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
        .onAppear {
            viewModel.observeOrders(for: viewModel.storeId)
        }
        .onDisappear {
            viewModel.stopObservingOrders()
        }
    }
}

#Preview {
    OrderProcessingView(viewModel: .constant(StoreManagementViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
