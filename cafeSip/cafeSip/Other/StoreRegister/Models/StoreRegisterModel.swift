//
//  StoreRegisterModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/20/25.
//

struct StoreRegisterModel {
    private var address: String
    private var detailAddress: String
    private var storeName: String
    
    init() {
        self.address = ""
        self.detailAddress = ""
        self.storeName = ""
    }
    
    func getAddressData() -> String {
        return address
    }
    mutating func setAddressData(newValue: String) {
        self.address = newValue
    }
    func getDetailAddressData() -> String {
        return detailAddress
    }
    mutating func setDetailAddressData(newValue: String) {
        self.detailAddress = newValue
    }
    func getStoreName() -> String {
        return storeName
    }
    mutating func setStoreName(newValue: String) {
        self.storeName = newValue
    }
    
    mutating func clear() {
        self.address = ""
        self.detailAddress = ""
        self.storeName = ""
    }
}
