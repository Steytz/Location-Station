//
//  Types.swift
//  LocationStation
//
//  Created by Steyt on 14.06.22.
//

import Foundation
import CoreLocation

struct TLocation: Hashable, Codable {
    let lat: Double
    let lng: Double
}

struct TPlace: Hashable, Codable {
    let name: String
    let type: String
    let location: TLocation
    let id: String
}

//---------
struct TTransport: Hashable, Codable {
    let mode: String
    let name: String
    let category: String
    let color: String?
    let textColor: String?
    let headsign: String
    let shortName: String?
}

struct TAgency: Hashable, Codable {
    let id: String
    let name: String
    let website: String?
}

struct TDepartures: Hashable, Codable, Identifiable {
    var id: UUID?
    let time: String
    let platform: String?
    let delay: Int?
    let transport: TTransport
    let agency: TAgency
}

struct TBoardsElement: Hashable, Codable {
    let place: TPlace
    var departures: Array<TDepartures>
}




struct TDeparture: Hashable, Codable {
    let boards: Array<TBoardsElement>
}
