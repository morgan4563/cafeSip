//
//  OrderView.swift
//  cafeSip
//
//  Created by hyunMac on 1/15/25.
//

import SwiftUI
import CodeScanner

struct OrderView: View {
    @State var viewModel = OrderViewModel()
    @State var navigationViewModel = OrderNavigationViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationViewModel.navigationPath) {
            VStack {
                Text("방문중인 매장을 선택합니다")
                    .font(.headline)
                    .padding()
                
                Button("카메라로 QR스캔") {
                    viewModel.isScanning = true
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.brown)
                .cornerRadius(10)
            }
            .onChange(of: viewModel.scannedCode, { oldValue, newValue in
                if let storeId = newValue, storeId != oldValue {
                    viewModel.inputQRData(code: storeId)
                    Task {
                        let loadStoreSuccess = await viewModel.loadStore()
                        if loadStoreSuccess {
                            navigationViewModel.goToSelectMenuView()
                        } else {
                            print("유효하지 않은 QR코드")
                        }
                    }
                }
            })
            .sheet(isPresented: $viewModel.isScanning) {
                CodeScannerView(
                    codeTypes: [.qr],
                    completion: { result in
                        switch result {
                        case .success(let scanResult):
                            viewModel.scannedCode = scanResult.string
                            viewModel.isScanning = false
                        case .failure(let error):
                            print("스캔실패: \(error.localizedDescription)")
                            viewModel.isScanning = false
                        }
                    }
                )
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "SelectMenuView":
                    SelectMenuView(viewModel: $viewModel, navigationViewModel: $navigationViewModel)
                case "MenuPaymentView":
                    MenuPaymentView(orderViewModel: $viewModel, navigationViewModel: $navigationViewModel)
                case "OrderStatusView":
                    OrderStatusView(orderViewModel: $viewModel, navigationViewModel: $navigationViewModel)
                default:
                    Text("잘못된접근")
                }
            }
        }
    }
}

#Preview {
    OrderView()
}
