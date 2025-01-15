//
//  OrderManager.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI
import FirebaseFirestore

class OrderManager {
    func createOrder(storeId: String, customerId: String, item: MenuItem) {
        let newOrderRef = Firestore.firestore().collection("orders").document()
        
        let orderData: [String:Any] = [
            "storeId" : storeId,
            "customerId" : customerId,
            "orderTime": Timestamp(),
            "menuId": item.id,
            "menuName": item.name,
            "price": item.price
        ]
        newOrderRef.setData(orderData) { error in
            if let error = error {
                print("오더 생성 실패\(error.localizedDescription)")
            }else {
                print("오더 생성 성공")
            }
        }
    }
}
