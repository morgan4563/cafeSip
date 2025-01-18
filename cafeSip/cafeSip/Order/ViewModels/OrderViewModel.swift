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
    var userName: String
    
    var isScanning = false
    var scannedCode: String?
    
    init() {
        let currentUser = AuthManager.shared.currentUser
        self.balance = currentUser?.balance ?? 0
        self.userId = currentUser?.id ?? ""
        self.userName = currentUser?.userName ?? ""
    }
    
    func loadStore() async -> Bool {
        do {
            let currentStore = try await Firestore.firestore().collection("stores").document(storeId).getDocument(as: Store.self)
            self.storeId = currentStore.id
            self.storeName = currentStore.name
            self.ownerId = currentStore.ownerId
            self.menuItems = currentStore.menuItems ?? [MenuItem]()
            print("스토어 데이터 로드 성공")
            return true
        } catch {
            print("스토어 데이터 로드 실패")
            return false
        }
    }
    
    func processPayment(menu: MenuItem) async -> Bool {
        guard let price = Int(menu.price) else {
            print("가격 변환 실패")
            return false
        }
        
        guard await getBalance() else { return false }
        guard balance >= price else { return false }
        guard await sendMoneyToStore(price: price) else { return false }
        guard let orderId = createOrder(menu: menu) else { return false }
        
        balance -= price
        updateBalance()
        
        self.orderId = orderId
        self.orderStatus = "preparing"
        
        return true
    }
    
    func getBalance() async -> Bool {
        do {
            let user = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            balance = user.balance
        } catch {
            print("balanceData 수신 실패")
            return false
        }
        return true
    }
    
    func sendMoneyToStore(price: Int) async -> Bool {
        do {
            let owner = try await Firestore.firestore().collection("users").document(ownerId).getDocument(as: User.self)
            let ownerBalance = owner.balance + price
            try await Firestore.firestore().collection("users").document(ownerId).updateData(
                ["balance": ownerBalance]
            )
        } catch {
            print("ownerBalnce 수정 실패")
            return false
        }
        return true
    }
    
    func createOrder(menu: MenuItem) -> String? {
        let orderId = UUID().uuidString
        let orderData = Order(
            id: orderId,
            storeId: storeId,
            customerId: userId,
            customerName: userName,
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
    
    
    func updateBalance() {
        Firestore.firestore().collection("users").document(userId).updateData(
            ["balance" : balance]
        )
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
    
    
}
