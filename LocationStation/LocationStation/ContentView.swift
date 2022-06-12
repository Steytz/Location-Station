//
//  ContentView.swift
//  LocationStation
//
//  Created by Steyt on 12.06.22.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.92897235052956, longitude: 6.943178858308985), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    var body: some View {
        Map(coordinateRegion: $region).ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
