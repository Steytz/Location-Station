//
//  LocationStationApp.swift
//  LocationStation
//
//  Created by Steyt on 12.06.22.
//

import SwiftUI

@main
struct LocationStationApp: App {
    @StateObject private var viewModel = MapViewModel()
    var body: some Scene {
        WindowGroup {
            MapView()
                .environmentObject(viewModel)
        }
    }
}
