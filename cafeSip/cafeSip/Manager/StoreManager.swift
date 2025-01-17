//
//  StoreManager.swift
//  cafeSip
//
//  Created by hyunMac on 1/17/25.
//

import SwiftUI
import FirebaseFirestore

@Observable
class StoreManager {
    static let shared = StoreManager()
    var currentStore: Store?
    
    func loadCurrentStoreData(storeId: String) async { // 분리필요
        do {
            self.currentStore = try await Firestore.firestore().collection("stores").document(storeId).getDocument(as: Store.self)
            print("스토어 데이터 로드 성공")
        } catch {
            print("스토어 데이터 로드 실패 : \(error.localizedDescription)")
        }
    }
    
    func uploadStoreData(storeAddress: String, storeDetailAddress: String, storeName: String, ownerId: String) async {
        guard !ownerId.isEmpty else {
            print("ownerId가 없습니다")
            return
        }
        
        let storeId = UUID().uuidString
        let storeData = Store(
            id: storeId,
            ownerId: ownerId,
            name: storeName,
            address: storeAddress,
            detailAddress: storeDetailAddress,
            menuItems: nil
        )
        
        do {
            let encodedStore = try Firestore.Encoder().encode(storeData)

            try await Firestore.firestore().collection("users").document(ownerId).updateData(["storeId" : storeId])
            try await Firestore.firestore().collection("stores").document(storeId).setData(encodedStore)
            
            currentStore = storeData
            print("스토어 등록 데이터 업로드 성공")
        } catch {
            print("스토어 등록 데이터 업로드 실패 : \(error.localizedDescription)")
        }
    }
}
