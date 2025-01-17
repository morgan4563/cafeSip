//
//  OrderProcessingView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct OrderProcessingView: View {
    @Binding var storeManagementViewModel: StoreManagementViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline){
                Text("주문목록")
                    .font(.title)
                    .fontWeight(.semibold)
                Text(StoreManager.shared.currentStore?.name ?? "스토어 이름을 불러올 수 없음")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.brown)
                    .opacity(0.8)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Divider()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    if storeManagementViewModel.orders.isEmpty {
                        Text("들어온 주문이 없습니다")
                            .fontWeight(.semibold)
                    }
                    ForEach(storeManagementViewModel.orders) { order in
                        VStack(alignment: .leading) {
                            Text("주문자 : \(order.customerName)")
                            Text("메뉴명 : \(order.menuName)")
                            Text("주문 시간 : \(order.orderTime, style: .time)")
                            if storeManagementViewModel.completedOrders.contains(order.id) {
                                Button() {
                                    Task {
                                        await storeManagementViewModel.deleteOrder(orderId: order.id)
                                    }
                                } label: {
                                    HStack {
                                        Text("주문삭제")
                                            .foregroundStyle(.red)
                                        Text("고객이 메뉴를 수령하면 눌러주세요")
                                            .foregroundStyle(.gray)
                                            .opacity(0.5)
                                    }
                                }
                            } else {
                                Button() {
                                    Task {
                                        do {
                                            try await storeManagementViewModel.updateOrderStatus(orderId: order.id)
                                            storeManagementViewModel.completedOrders.insert(order.id)
                                        } catch {
                                            print("주문 상태 변경 실패")
                                        }
                                    }
                                } label: {
                                    HStack{
                                        Text("주문완료")
                                            .foregroundStyle(.green)
                                        Text("메뉴 준비가 완료되면 눌러주세요")
                                            .foregroundStyle(.gray)
                                            .opacity(0.5)
                                    }
                                }
                            }
                        }
                        .fontWeight(.semibold)
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
            guard let storeId = StoreManager.shared.currentStore?.id else {
                print("currentStoreId 존재하지않음")
                return
            }
            storeManagementViewModel.observeOrders(storeId: storeId)
        }
        .onDisappear {
            storeManagementViewModel.stopObservingOrders()
        }
    }
}

#Preview {
    OrderProcessingView(storeManagementViewModel: .constant(StoreManagementViewModel()), navigationViewModel: .constant(OtherNavigationViewModel()))
}
