//
//  StoreManagementView.swift
//  cafeSip
//
//  Created by hyunMac on 1/13/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct StoreManagementView: View {
    @Binding var storeManagementViewModel: StoreManagementViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button {
                storeManagementViewModel.showQRView = true
            } label: {
                HStack{
                    Image(systemName: "qrcode")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black).opacity(0.8)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            .sheet(isPresented: $storeManagementViewModel.showQRView) {
                if let currentStoreId = StoreManager.shared.currentStore?.id {
                    QRCodeView(currentStoreId: currentStoreId)
                } else {
                    Text("사용자 정보 수집 불가")
                }
            }
            
            Text(StoreManager.shared.currentStore?.name ?? "")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Button {
                navigationViewModel.goToMenuRegistrationView()
            } label: {
                Text("메뉴등록")
                    .foregroundStyle(.brown)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            
            Rectangle()
                .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
                .foregroundStyle(.black).opacity(0.5)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(StoreManager.shared.currentStore?.menuItems ?? []) { menu in
                        HStack {
                            Text(menu.name)
                                .font(.headline)
                            Spacer()
                            Text(menu.description)
                            Spacer()
                            Text("\(menu.price)원")
                        }
                        .padding(.horizontal)
                    }
                }
            }
            Spacer()
            
            Button {
                navigationViewModel.goToOrderProcessingView()
            } label: {
                Text("주문 확인")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    StoreManagementView(storeManagementViewModel: .constant(StoreManagementViewModel()),navigationViewModel: .constant(OtherNavigationViewModel()))
}
