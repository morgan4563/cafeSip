//
//  ReverseGeocodingResponse.swift
//  cafeSip
//
//  Created by hyunMac on 1/11/25.
//

struct ReverseGeocodingResponse {
    let status: Status
    let results: [Result]
}

struct Status {
    let code: Int
    let name: String
    let message: String
}

struct Result {
    let name: String
    let code: Code
    let region: Region
    let land: Land
}

struct Code {
    let id: String
    let type: String
    let mappingId: String
}

struct Region {
    let area0: Area
    let area1: Area
    let area2: Area
    let area3: Area
    let area4: Area
}

struct Area {
    let name: String
    let coords: Coords
}

struct Coords {
    let center: Center
}

struct Center {
    let crs: String
    let x: Double
    let y: Double
}

struct Land {
    let type: String
    let number1: String
    let number2: String
    let addition0: Addition
    let addition1: Addition
    let addition2: Addition
    let addition3: Addition
    let addition4: Addition
    let coords: Coords
}

struct Addition {
    let type: String
    let value: String
}


