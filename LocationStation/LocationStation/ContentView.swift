//
//  ContentView.swift
//  LocationStation
//
//  Created by Steyt on 12.06.22.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .onAppear{
                viewModel.checkIsLocationServiceOn()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
