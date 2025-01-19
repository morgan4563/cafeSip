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
    private var storeManagementModel = StoreManagementModel()
    var showQRView = false
    var listener: ListenerRegistration?
    var completedOrders: Set<String> = []
    
    var newMenuName: String {
        get { storeManagementModel.getNewMenuName() }
        set { storeManagementModel.setNewMenuName(newValue) }
    }
    
    var newMenuDescription: String {
        get { storeManagementModel.getNewMenuDescription() }
        set { storeManagementModel.setNewMenuDescription(newValue) }
    }
    
    var newMenuPrice: String {
        get { storeManagementModel.getNewMenuPrice() }
        set { storeManagementModel.setNewMenuPrice(newValue) }
    }
    
    var orders: [Order] {
        get { storeManagementModel.getOrders() }
        set { storeManagementModel.setOrders(newValue) }
    }
    
    func addMenuItem(storeId: String) {
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
            if var currentStore = StoreManager.shared.currentStore {
                if currentStore.menuItems == nil {
                    currentStore.menuItems = []
                }
                currentStore.menuItems?.append(newMenu)
                //Store Class로 변경할지 재할당할지 고민 다시 해볼것
                StoreManager.shared.currentStore = currentStore
            }
            clearFields()
        } catch {
            print("메뉴 추가 실패 에러")
        }
    }
    func clearFields() {
        newMenuName = ""
        newMenuDescription = ""
        newMenuPrice = ""
    }
    
    func observeOrders(storeId: String) {
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
    
    func updateOrderStatus(orderId: String) async throws {
        try await Firestore.firestore().collection("orders").document(orderId).updateData(["status": "Ready"])
    }
    
    func deleteOrder(orderId: String) async {
        do {
            try await Firestore.firestore().collection("orders").document(orderId).delete()
        } catch {
            print("주문 삭제 실패 \(error.localizedDescription)")
        }
    }
}
