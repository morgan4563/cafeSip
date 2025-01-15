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
    
    var body: some View {
        VStack {
            Text("방문중인 매장을 선택합니다")
                .font(.headline)
                .padding()
            
            if let code = scannedCode {
                Text(code)
                    .padding()
            }
            
            Button("카메라로 QR스캔") {
                isScanning = true
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
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
    }
}

#Preview {
    OrderView()
}
