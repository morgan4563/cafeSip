//
//  StoreManagementViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/14/25.
//
import SwiftUI
import NMapsMap

@Observable
class StoreManagementViewModel {
    var storeName = "카페카페"
    var menuItems = [MenuItem]()
    
    var newMenuName = ""
    var newMenuDescription = ""
    var newMenuPrice = ""
    
    func updateStoreData(name: String) {
        self.storeName = name
    }
    func addMenuItem() {
        guard newMenuName != "" && newMenuDescription != "" && newMenuPrice != "" else {
            print("모든 필드를 올바르게 입력해야 합니다.")
            return
        }
        let newMenu = MenuItem(name: newMenuName, description: newMenuDescription, price: newMenuPrice)
        menuItems.append(newMenu)
        clearFields()
    }
    func clearFields() {
        newMenuName = ""
        newMenuDescription = ""
        newMenuPrice = ""
    }
}
