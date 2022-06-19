//
//  Types.swift
//  LocationStation
//
//  Created by Steyt on 14.06.22.
//

import Foundation

struct TLocation: Hashable, Codable {
    let lat: Float
    let lng: Float
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

struct TDepartures: Hashable, Codable {
    let time: String
    let platform: String?
    let delay: Int?
    let transport: TTransport
    let agency: TAgency
}

struct TBoardsElement: Hashable, Codable {
    let place: TPlace
    let departures: Array<TDepartures>
}




struct TDeparture: Hashable, Codable {
    let boards: Array<TBoardsElement>
}
