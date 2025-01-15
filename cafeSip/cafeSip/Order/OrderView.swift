//
//  OrderView.swift
//  cafeSip
//
//  Created by hyunMac on 1/15/25.
//

import SwiftUI
import CodeScanner

struct OrderView: View {
    @State private var isScanning = false
    @State private var scannedCode: String?
    @State var orderViewModel = OrderViewModel()
    @State var navigationViewModel = OrderNavigationViewModel()
    @Binding var payViewModel: PayViewModel
    
    var body: some View {
        NavigationStack(path: $navigationViewModel.navigationPath) {
            VStack {
                Text("방문중인 매장을 선택합니다")
                    .font(.headline)
                    .padding()
                
                Button("카메라로 QR스캔") {
                    isScanning = true
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.brown)
                .cornerRadius(10)
            }
            
            .onChange(of: scannedCode, { oldValue, newValue in
                if let code = newValue, code != oldValue {
                    orderViewModel.inputQRData(code: code)
                    Task {
                        await orderViewModel.loadStore()
                    }
                    navigationViewModel.goToSelectMenuView()
                }
            })
            .sheet(isPresented: $isScanning) {
                CodeScannerView(
                    codeTypes: [.qr],
                    completion: { result in
                        switch result {
                        case .success(let scanResult):
                            scannedCode = scanResult.string
                            isScanning = false
                        case .failure(let error):
                            print("스캔실패: \(error.localizedDescription)")
                            isScanning = false
                        }
                    }
                )
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                    // storeRegistration
                case "SelectMenuView":
                    SelectMenuView(viewModel: $orderViewModel, navigationViewModel: $navigationViewModel, payViewModel: $payViewModel)
                case "MenuPaymentView":
                    MenuPaymentView(orderViewModel: $orderViewModel, payViewModel: $payViewModel, navigationViewModel: $navigationViewModel)
                default:
                    Text("잘못된접근")
                }
            }
        }
    }
}

#Preview {
    OrderView(payViewModel: .constant(PayViewModel()))
}
