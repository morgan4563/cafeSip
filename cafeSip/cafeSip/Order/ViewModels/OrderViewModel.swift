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
    var orderModel = OrderModel()
    
    var isScanning = false
    var scannedCode: String = ""
    
    var storeId: String {
        get { orderModel.getStoreId() }
        set { orderModel.setStoreId(id: newValue) }
    }
    
    var storeName: String {
        get { orderModel.getStoreName() }
        set { orderModel.setStoreName(name: newValue) }
    }
    
    var ownerId: String {
        get { orderModel.getOwnerId() }
        set { orderModel.setOwnerId(id: newValue) }
    }
    
    var menuItems: [MenuItem] {
        get { orderModel.getMenuItems() }
        set { orderModel.setMenuItems(items: newValue) }
    }
    
    var selectedMenu: MenuItem? {
        get { orderModel.getSelectedMenu() }
        set { orderModel.setSelectedMenu(menu: newValue) }
    }
    
    var userId: String {
        get { orderModel.getUserId() }
        set { orderModel.setUserId(id: newValue) }
    }

    var userName: String {
        get { orderModel.getUserName() }
        set { orderModel.setUserName(name: newValue) }
    }
    
    var balance: Int {
        get { orderModel.getBalance() }
        set { orderModel.setBalance(balance: newValue) }
    }
    
    var orderId: String {
        get { orderModel.getOrderId() }
        set { orderModel.setOrderId(id: newValue) }
    }
    
    var orderStatus: String {
        get { orderModel.getOrderStatus() }
        set { orderModel.setOrderStatus(status: newValue) }
    }
    
    var listener: ListenerRegistration?

    
    func loadStore() async -> Bool {
        do {
            let currentStore = try await Firestore.firestore().collection("stores").document(storeId).getDocument(as: Store.self)
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
        guard loadUser() else {
            print("유저 정보 수집 실패")
            return false
        }
        guard let price = Int(menu.price) else {
            print("가격 변환 실패")
            return false
        }
        
        guard await getBalance() else { return false }
        guard self.balance >= price else { return false }
        guard await sendMoneyToStore(price: price) else { return false }
        self.balance -= price
        updateBalance()
        
        guard let orderId = createOrder(menu: menu) else { return false }
        
        self.orderId = orderId
        self.orderStatus = "preparing"
        
        return true
    }
    
    func loadUser() -> Bool {
        guard let currentUser = AuthManager.shared.currentUser else {
            return false
        }
        self.userId = currentUser.id
        self.userName = currentUser.userName
        return true
    }
    
    func getBalance() async -> Bool {
        do {
            let user = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            self.balance = user.balance
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
