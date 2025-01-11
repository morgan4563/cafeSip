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

struct ReverseGeocodingRequest {
    private let baseURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc"
    let position: NMGLatLng
    
    init(position: NMGLatLng) {
        self.position = position
    }
    
    func makeURL() -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "request", value: "coordsToaddr"),
            URLQueryItem(name: "coords", value: "\(position.lng),\(position.lat)"),
            URLQueryItem(name: "sourcecrs", value: "epsg:4326"),
            URLQueryItem(name: "orders", value: "roadaddr,addr"),
            URLQueryItem(name: "output", value: "json")
        ]
        guard let url = urlComponents?.url else {
            print("Failed to create URL")
            return nil
        }
        return url
    }
    
    func makeRequest() -> URLRequest? {
        guard let url = makeURL() else {
            print("Failed to create Request")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue(NaverCloudPlatformKey.clientId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue(NaverCloudPlatformKey.clientSecret, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        
        return request
    }
    
    func sendRequest(completion: @escaping (String?) -> Void) {
        guard let request = makeRequest() else {
            print("Failed to create request")
            return completion(nil)
        }
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                print("URLSessionError")
                return
            }
            
            guard let data = data else {
                print("Data not received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ReverseGeocodingResponse.self, from: data)
                if let result = decodedResponse.results.first {
                    let address = "\(result.region.area1.name) \(result.region.area2.name) \(result.region.area3.name) \(result.region.area4.name)"
                    return completion(address)
                }
                
            } catch {
                print("JSON decoding error")
            }
        }
    }
}

struct NaverMapView: UIViewRepresentable {
    @Binding var address: String
    
    class Coordinator: NSObject, NMFMapViewCameraDelegate {
        var parent: NaverMapView
        
        init(parent: NaverMapView) {
            self.parent = parent
        }
        
        func mapViewCameraIdle(_ mapView: NMFMapView) {
            let position = mapView.cameraPosition.target
//            let lat = position.lat
//            let lng = position.lng
//
//            parent.address = "위도: \(lat), 경도: \(lng)"
//            print("위도: \(lat), 경도: \(lng)")
            let reverseGeocodingResponse = ReverseGeocodingRequest(position: position)
            reverseGeocodingResponse.sendRequest(completion: { address in
                guard let addressResult = address else {
                    print("위치 데이터 출력 실패")
                    return
                }
                self.parent.address = addressResult
            })
            
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
