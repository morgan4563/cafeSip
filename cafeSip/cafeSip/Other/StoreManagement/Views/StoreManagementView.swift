//
//  StoreManagementView.swift
//  cafeSip
//
//  Created by hyunMac on 1/13/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct StoreManagementView: View {
    @Binding var viewModel: StoreManagementViewModel
    @Binding var navigationViewModel: OtherNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showQRView = false
    
    var body: some View {
        VStack {
            Button {
                showQRView = true
            } label: {
                Text("QR확인")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
            }
            .sheet(isPresented: $showQRView) {
                if let currentStoreId = AuthManager.shared.currentStore?.id {
                    QRCodeView(currentStoreId: currentStoreId)
                } else {
                    Text("사용자 정보 수집 불가")
                }
            }
            
            
            Text(viewModel.storeName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Button {
                navigationViewModel.goToMenuRegistrationView()
            } label: {
                Text("메뉴등록")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.menuItems) { menu in
                        HStack {
                            Text(menu.name)
                                .font(.headline)
                            Spacer()
                            Text(menu.description)
                            Spacer()
                            Text("\(menu.price)원")
                        }
                    }
                }
            }
            Spacer()
            
            Text("주문 알림 확인")
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

struct QRCodeView: View {
    var currentStoreId: String
    
    var body: some View {
        VStack {
            Text("QR 코드")
                .font(.headline)
                .padding(.top)
            
            if let qrCodeImage = QRCodeGenerator.generateQRCode(from: currentStoreId) {
                Image(uiImage: qrCodeImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Text("QR코드를 생성할 수 없습니다.")
            }
        }
    }
}

struct QRCodeGenerator {
    static func generateQRCode(from: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(from.utf8)
        
        if let outputImage = filter.outputImage {
            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
}

#Preview {
    StoreManagementView(viewModel: .constant(StoreManagementViewModel()),navigationViewModel: .constant(OtherNavigationViewModel()))
}
