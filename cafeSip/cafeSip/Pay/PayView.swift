//
//  PayView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct PayView: View {
    @State var viewModel = PayViewModel()
    var body: some View {
        VStack {
            Text("잔액 : \(viewModel.balance)")
                .font(.headline)
            
            Button {
                viewModel.chargePaymoney(amount: 1000)
            } label: {
                Text("충전 1000원")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.brown)
                    .cornerRadius(10)
            }
            
            Button {
                Task {
                    await viewModel.getBalance()
                }
            } label: {
                Text("잔액 새로고침")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.brown)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    PayView()
}
