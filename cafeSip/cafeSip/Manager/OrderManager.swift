//
//  OrderManager.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI
import FirebaseFirestore

class OrderManager {
    func createOrder(storeId: String, customerId: String, customerName: String, item: MenuItem) {
        let newOrderRef = Firestore.firestore().collection("orders").document()
        let orderId = newOrderRef.documentID
        let orderData = Order(id: orderId, storeId: storeId, customerId: customerId, customerName: customerName, orderTime: Date(), status: "preparing", menuId: item.id, menuName: item.name, price: item.price)

        do {
            try newOrderRef.setData(from: orderData) { error in
                if let error = error {
                    print("오더 생성 실패\(error.localizedDescription)")
                }else {
                    print("오더 생성 성공")
                }
            }
        } catch {
            print("주문 데이터 변환 실패")
        }
    }
}
