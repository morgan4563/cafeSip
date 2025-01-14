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
    
    func getStoreData() {
        guard let storeData = AuthManager.shared.currentStore else {
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
        menuItems.append(newMenu)
        clearFields()
        
        let storeRef = Firestore.firestore().collection("stores").document(storeId)
        do {
            let menuData = try Firestore.Encoder().encode(newMenu)
            storeRef.updateData([
                "menuItems": FieldValue.arrayUnion([menuData])
            ]) { error in
                if let error = error {
                    print("Firebase 메뉴 추가 실패\(error)")
                } else {
                    print("Firebase 메뉴 추가 성공")
                }
            }
        } catch {
            print("Firestore 데이터 인코딩 실패")
        }
    }
    func clearFields() {
        newMenuName = ""
        newMenuDescription = ""
        newMenuPrice = ""
    }
}
