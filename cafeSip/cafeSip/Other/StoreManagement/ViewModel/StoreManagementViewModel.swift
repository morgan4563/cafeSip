//
//  StoreManagementViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/14/25.
//
import SwiftUI
import NMapsMap
import FirebaseFirestore

@Observable
class StoreManagementViewModel {
    var storeId = ""
    var storeName = ""
    var menuItems = [MenuItem]()
    
    var newMenuName = ""
    var newMenuDescription = ""
    var newMenuPrice = ""
    
    init() {
        updateStoreData()
    }
    
    func updateStoreData() {
        guard let userId = AuthManager.shared.currentAuthUser?.uid else {
            print("유저정보 수집 실패")
            return
        }
        let storeRef = Firestore.firestore().collection("stores").document(userId)
        
        storeRef.getDocument { document, error in
            if let error = error {
                print("firebase데이터 수신중 에러 발생, \(error.localizedDescription)")
                return
            }
            guard let document = document else {
                print("document가 존재하지않음")
                return
            }
            
            do {
                let storeData = try document.data(as: Store.self)
                self.storeId = storeData.id
                self.storeName = storeData.name
                self.menuItems = storeData.menuItems ?? []
                
            } catch {
                print("Firestore 데이터 디코딩 실패")
            }
        }
    }
    
    func addMenuItem() {
        guard newMenuName != "" && newMenuDescription != "" && newMenuPrice != "" else {
            print("모든 필드를 올바르게 입력해야 합니다.")
            return
        }
        let newMenu = MenuItem(name: newMenuName, description: newMenuDescription, price: newMenuPrice)
        menuItems.append(newMenu)
        clearFields()
        
        let storeRef = Firestore.firestore().collection("stores").document(storeId)
    }
    func clearFields() {
        newMenuName = ""
        newMenuDescription = ""
        newMenuPrice = ""
    }
}
