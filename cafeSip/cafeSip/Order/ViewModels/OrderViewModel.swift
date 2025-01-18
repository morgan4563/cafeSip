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
    
    
    func inputQRData(code: String) {
        print(code)
        self.storeId = code
    }
    
    func loadStore() async {
        do {
            self.currentStore = try await Firestore.firestore().collection("stores").document(storeId).getDocument(as: Store.self)
            // 추후 예외처리 다시 해주기
            self.storeId = currentStore?.id ?? ""
            self.storeName = currentStore?.name ?? ""
            self.ownerId = currentStore?.ownerId ?? ""
            self.menuItems = currentStore?.menuItems ?? [MenuItem]()
            print("loadStore 성공")
        } catch {
            print("스토어 데이터 로드 실패")
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
}
