//
//  OtherView.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import SwiftUI

struct OtherView: View {
    @State var storeRegisterViewModel = StoreRegisterViewModel()
    @State var otherNavigationViewModel = OtherNavigationViewModel()
    
    var body: some View {
        NavigationStack(path: $otherNavigationViewModel.navigationPath) {
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
                    otherNavigationViewModel.goToAddressSelectionView()
                }
                .padding(.horizontal, 16)
                .foregroundStyle(.black)
                .opacity(0.8)
                
                Button("\(Image(systemName: "house.circle.fill"))매장관리") {
                    // 매장등록 체크(임시)
                    guard storeRegisterViewModel.storeName != "" else {
                        print("매장등록이 먼저 진행되어야한다")
                        return
                    }
                    
                    otherNavigationViewModel.goToAddressSelectionView()
                }
                .padding(16)
                .foregroundStyle(.black)
                .opacity(0.8)
                
                Spacer()
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                    // storeRegistration
                case "AddressSelectionView":
                    AddressSelectionView(viewModel: $storeRegisterViewModel, navigationViewModel: $otherNavigationViewModel)
                case "AddressDetailView":
                    AddressDetailView(viewModel: $storeRegisterViewModel, navigationViewModel: $otherNavigationViewModel)
                case "StoreNameView":
                    StoreNameView(viewModel: $storeRegisterViewModel, navigationViewModel: $otherNavigationViewModel)
                case "CompleteStoreRegistrationView":
                    CompleteStoreRegistrationView(viewModel: $storeRegisterViewModel, navigationViewModel: $otherNavigationViewModel)
                
                    // storeManage
//                case "StoreManagementView":
//                    StoreManagementView(viewModel: $viewModel)
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
