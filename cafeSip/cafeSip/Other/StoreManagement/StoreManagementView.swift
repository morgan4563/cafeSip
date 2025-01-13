//
//  StoreManagementView.swift
//  cafeSip
//
//  Created by hyunMac on 1/13/25.
//

import SwiftUI

struct StoreManagementView: View {
    @Binding var viewModel: OtherViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StoreManagementView(viewModel: .constant(OtherViewModel()))
}
