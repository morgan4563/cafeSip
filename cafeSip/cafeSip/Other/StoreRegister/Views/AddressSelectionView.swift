//
//  AddressSelectionView.swift
//  cafeSip
//
//  Created by hyunMac on 1/10/25.
//

import SwiftUI
import NMapsMap

struct AddressSelectionView: View {
    @State var address = "서울시 용산구 땡땡로"
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
                NaverMapView(address: $address)
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
                    Text(address)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                }
            
            NavigationLink {
                AddressSelectionView()
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

//class GeocodingAPI {
//    private let baseURL
//}

struct NaverMapView: UIViewRepresentable {
    @Binding var address: String
    
    class Coordinator: NSObject, NMFMapViewCameraDelegate {
        var parent: NaverMapView
        
        init(parent: NaverMapView) {
            self.parent = parent
        }
        
        func mapViewCameraIdle(_ mapView: NMFMapView) {
            let position = mapView.cameraPosition.target
            let lat = position.lat
            let lng = position.lng

            parent.address = "위도: \(lat), 경도: \(lng)"
            print("위도: \(lat), 경도: \(lng)")
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let mapView = NMFNaverMapView(frame: .zero)
        mapView.mapView.addCameraDelegate(delegate: context.coordinator)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    AddressSelectionView()
}
