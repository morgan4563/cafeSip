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
    var menuItems = [MenuItem]()
    
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
            self.menuItems = currentStore?.menuItems ?? [MenuItem]()
            print("loadStore 성공")
        } catch {
            print("스토어 데이터 로드 실패")
        }
    }
}
