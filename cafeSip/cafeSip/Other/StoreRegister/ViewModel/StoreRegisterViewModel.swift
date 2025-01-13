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
    var address = "주소 정보를 수집중입니다."
    var detailAddress = ""
    var storeName = ""
    var isStoreRegistered = false
    
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
