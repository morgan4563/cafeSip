//
//  AddressSelectionViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//
import SwiftUI
import NMapsMap

@Observable
class StoreRegisterViewModel {
    private var storeRegisterModel = StoreRegisterModel()
    
    var address: String {
        get { storeRegisterModel.getAddress() }
        set { storeRegisterModel.setAddress(newValue: newValue) }
    }
    
    var detailAddress: String {
        get { storeRegisterModel.getAddress() }
        set { storeRegisterModel.setDetailAddress(newValue: newValue) }
    }
    
    var storeName: String {
        get { storeRegisterModel.getStoreName() }
        set { storeRegisterModel.setStoreName(newValue: newValue) }
    }
    
    func getRoadAddress(from: NMGLatLng) {
        let reverseGeocodingResponse = ReverseGeocodingRequest(position: from)
        reverseGeocodingResponse.sendRequest(completion: { address in
            guard let addressResult = address else {
                print("위치 데이터 출력 실패")
                return
            }
            self.address = addressResult
        })
    }
}
