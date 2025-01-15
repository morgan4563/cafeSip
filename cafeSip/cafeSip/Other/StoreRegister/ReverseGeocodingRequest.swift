//
//  ReverseGeocodingRequest.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//
import SwiftUI
import NMapsMap

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
            if error != nil {
                print("URLSessionError")
                return
            }
            
            guard let data = data else {
                print("Data not received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ReverseGeocodingResponseModel.self, from: data)
                if let result = decodedResponse.results.first {
                    var address = "\(result.region.area1.name) \(result.region.area2.name) \(result.region.area3.name)"
                    
                    if result.region.area4.name != "" {
                        address += " \(result.region.area4.name)"
                    }
                    if let landName = result.land.name {
                        address += " \(landName)"
                    }
                    
                    if result.land.number1 != "" && result.land.number2 != "" {
                        address += " \(result.land.number1)-\(result.land.number2)"
                    }else if result.land.number1 != "" {
                        address += " \(result.land.number1)"
                    }
                    
                    return completion(address)
                }
                
            } catch {
                print("JSON decoding error")
            }
        }
        task.resume()
    }
}
