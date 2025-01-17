//
//  StoreManagementViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/14/25.
//
import SwiftUI
import FirebaseFirestore

@Observable
class StoreManagementViewModel {
    var storeId = ""
    var storeName = ""
    var menuItems = [MenuItem]()
    
    var newMenuName = ""
    var newMenuDescription = ""
    var newMenuPrice = ""
    
    var showQRView = false
    
    var listener: ListenerRegistration?
    var orders: [Order] = []
    
    func getStoreData() {
        guard let storeData = StoreManager.shared.currentStore else {
            print("storeData불러오기 실패")
            return
        }
        self.storeId = storeData.id
        self.storeName = storeData.name
        self.menuItems = storeData.menuItems ?? []
    }
    
    func addMenuItem() {
        guard newMenuName != "" && newMenuDescription != "" && newMenuPrice != "" else {
            print("모든 필드를 올바르게 입력해야 합니다.")
            return
        }
        let newMenu = MenuItem(name: newMenuName, description: newMenuDescription, price: newMenuPrice)
        let storeRef = Firestore.firestore().collection("stores").document(storeId)
        
        do {
            let menuData = try Firestore.Encoder().encode(newMenu)
            storeRef.updateData([
                "menuItems": FieldValue.arrayUnion([menuData])
            ])
            menuItems.append(newMenu)
            clearFields()
        } catch {
            print("Firestore 데이터 인코딩 실패")
        }
    }
    func clearFields() {
        newMenuName = ""
        newMenuDescription = ""
        newMenuPrice = ""
    }
    
    func observeOrders(for storeId: String) {
        stopObservingOrders()
        listener = Firestore.firestore().collection("orders")
            .whereField("storeId", isEqualTo: storeId)
            .order(by: "orderTime", descending: false)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("주문데이터 옵저빙실패 \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self?.orders = documents.compactMap { doc in
                    try? doc.data(as: Order.self)
                }
                print("옵저빙된 주문 수 : \(self?.orders.count ?? 0)")
            }
    }
    
    func stopObservingOrders() {
        listener?.remove()
        listener = nil
    }
    
    func updateOrderStatus(orderId: String) {
        Firestore.firestore().collection("orders").document(orderId).updateData([
            "status": "Ready"
        ]) { error in
            if let error = error {
                print("주문상태 변경실패 \(error.localizedDescription)")
            } else {
                print("주문상태가 Ready로 업데이트 되었다")
            }
        }
    }
    
    func deleteOrder(orderId: String) {
        Firestore.firestore().collection("orders").document(orderId).delete() { error in
            if let error = error {
                print("주문 삭제 실패 \(error.localizedDescription)")
            }else {
                print("주문 삭제 성공")
            }
        }
    }
}
