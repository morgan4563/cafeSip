//
//  OrderViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/15/25.
//

import Foundation
import FirebaseFirestore

@Observable
class OrderViewModel {
    var currentStore: Store?
    var storeId = ""
    var storeName = ""
    var ownerId = ""
    var menuItems = [MenuItem]()
    var selectedMenu: MenuItem?
    
    var orderId = ""
    var orderStatus = ""
    
    var listener: ListenerRegistration?
    
    var balance: Int
    var userId: String
    
    var isScanning = false
    var scannedCode: String?
    
    init() {
        let currentUser = AuthManager.shared.currentUser
        self.balance = currentUser?.balance ?? 0
        self.userId = currentUser?.id ?? ""
    }
    
    func processPayment(price: Int, ownerId: String) async -> Bool {
        guard balance >= price else { return false }
        balance -= price
        updateBalance()
        await sendMoneyToStore(ownerId: ownerId, price: price)
        return true
    }
    
    func sendMoneyToStore(ownerId: String, price: Int) async {
        do {
            let owner = try await Firestore.firestore().collection("users").document(ownerId).getDocument(as: User.self)
            let ownerBalance = owner.balance + price
            try await Firestore.firestore().collection("users").document(ownerId).updateData(
                ["balance": ownerBalance]
            )
        } catch {
            print("ownerBalnce 수정 실패")
        }
    }
    
    func updateBalance() {
        Firestore.firestore().collection("users").document(userId).updateData(
            ["balance" : balance]
        )
    }
    
    
    func inputQRData(code: String) {
        self.storeId = code
    }
    
    func loadStore() async -> Bool {
        do {
            self.currentStore = try await Firestore.firestore().collection("stores").document(storeId).getDocument(as: Store.self)
            self.storeId = currentStore?.id ?? ""
            self.storeName = currentStore?.name ?? ""
            self.ownerId = currentStore?.ownerId ?? ""
            self.menuItems = currentStore?.menuItems ?? [MenuItem]()
            print("loadStore 성공")
            return true
        } catch {
            print("스토어 데이터 로드 실패")
            return false
        }
    }
    
    func observeStatus() {
        listener = Firestore.firestore().collection("orders").document(orderId)
            .addSnapshotListener{ [weak self] snapshot, error in
                if let error = error {
                    print("옵저빙 실패: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("snapshot nil")
                    return
                }
                
                print("Firestore 리스너 호출")
                print("문서 ,\(self?.orderId ?? "" )")
                print("문서 존재, \(snapshot.exists)")
                print("문서 데이터, \(snapshot.data() ?? [:])")
                
                if snapshot.exists {
                    guard let document = snapshot.data() else { return }
                    if let status = document["status"] as? String {
                        self?.orderStatus = status
                        print("orderStatus : \(self?.orderStatus ?? "")")
                    }
                } else {
                    print("오더 삭제됨")
                    self?.orderStatus = "Deleted"
                }
            }
    }
    
    func stopOvserving() {
        listener?.remove()
        listener = nil
    }
    
    func createOrder(menu: MenuItem, customerId: String, customerName: String) -> String? {
        let orderId = UUID().uuidString
        let orderData = Order(
            id: orderId,
            storeId: storeId,
            customerId: customerId,
            customerName: customerName,
            orderTime: Date(),
            status: "preparing",
            menuName: menu.name,
            price: menu.price
        )
        do {
            try Firestore.firestore().collection("orders").document(orderId).setData(from: orderData)
        } catch {
            print("order 생성 실패")
            return nil
        }
        return orderId
    }
}
