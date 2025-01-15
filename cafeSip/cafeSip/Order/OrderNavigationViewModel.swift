//
//  OrderNavigationViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

@Observable
class OrderNavigationViewModel {
    var navigationPath = NavigationPath()
    
    // storeRegistration
    func goToSelectMenuView() {
        navigationPath.append("SelectMenuView")
    }
}
