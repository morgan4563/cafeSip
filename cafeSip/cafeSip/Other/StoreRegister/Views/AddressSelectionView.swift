//
//  AddressSelectionView.swift
//  cafeSip
//
//  Created by hyunMac on 1/10/25.
//

import SwiftUI

struct AddressSelectionView: View {
    @State var viewModel = AddressSelectionViewModel()
    
    var body: some View {
        VStack {
            Text("매장 등록")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("영업중인 매장을 등록합니다. 지도를 통해서 주소확인후 해당 주소로 설정을 통해 상세 주소를 입력해 주세요.")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            Divider()
            ZStack {
                NaverMapView(viewModel: $viewModel)
                    .frame(maxWidth: .infinity)
                Image(systemName: "mappin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.brown)
                    .shadow(color: .white, radius: 1)
            }
            
            Rectangle()
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .overlay(alignment: .leading) {
                    Text(viewModel.address)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding()
                }
            
            NavigationLink {
                AddressDetailView(viewModel: $viewModel)
            } label: {
                Text("해당 주소로 설정")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    AddressSelectionView()
}
