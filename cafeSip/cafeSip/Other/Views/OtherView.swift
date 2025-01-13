//
//  OtherView.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import SwiftUI

struct OtherView: View {
    @State var viewModel = OtherViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack(alignment: .leading) {
                Text("Other")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .padding()
                
                Divider()
                
                Text("매장 관리")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 4)
                
                Button("\(Image(systemName: "house.circle.fill"))매장등록") {
                    viewModel.goToAddressSelectionView()
                }
                .padding(.horizontal, 16)
                .foregroundStyle(.black)
                .opacity(0.8)
                
                Spacer()
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                    // storeRegistration
                case "AddressSelectionView":
                    AddressSelectionView(viewModel: $viewModel)
                case "AddressDetailView":
                    AddressDetailView(viewModel: $viewModel)
                case "StoreNameView":
                    StoreNameView(viewModel: $viewModel)
                case "CompleteStoreRegistrationView":
                    CompleteStoreRegistrationView(viewModel: $viewModel)
                
                    // storeManage
                case "StoreManagementView":
                    StoreManagementView(viewModel: $viewModel)
                default:
                    Text("잘못된접근")
                }
            }
        }
    }
}


#Preview {
    OtherView()
}
