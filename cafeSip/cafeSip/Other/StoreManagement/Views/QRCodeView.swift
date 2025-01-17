//
//  QRCodeView.swift
//  cafeSip
//
//  Created by hyunMac on 1/18/25.
//
import SwiftUI

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
