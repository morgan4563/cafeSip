//
//  OtherNavigationViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/14/25.
//

import SwiftUI

@Observable
class OtherNavigationViewModel {
    var navigationPath = NavigationPath()
    
    // storeRegistration
    func goToAddressSelectionView() {
        navigationPath.append("AddressSelectionView")
    }
    func goToAddressDetailView() {
        navigationPath.append("AddressDetailView")
    }
    func goToStoreNameView() {
        navigationPath.append("StoreNameView")
    }
    func goToCompleteStoreRegistrationView() {
        navigationPath.append("CompleteStoreRegistrationView")
    }
    
    // storeManagement
    func goToStoreManagementView() {
        navigationPath.append("StoreManagementView")
    }
    
    
    // mainView Back
    func goToOtherView() {
        navigationPath = NavigationPath()
    }
}
