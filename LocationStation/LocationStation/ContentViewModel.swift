//
//  ContentViewModel.swift
//  LocationStation
//
//  Created by Steyt on 12.06.22.
//
import MapKit

enum MapDefaults {
    static let initialLocation = CLLocationCoordinate2D(latitude: 50.92897235052956, longitude: 6.943178858308985)
    static let intialZoom = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDefaults.initialLocation , span: MapDefaults.intialZoom)
    
    var locationManager: CLLocationManager?
    
    func checkIsLocationServiceOn(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            // Todo show alert to tell user to turn location on
        }
    }
    
   private func handleLocationPermission() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
           print("Your location is restricted, maybe check for parental controls.")
        case .denied:
            print("It seems as if you have denied location permission for this app, please go to settings and give location permissions to this app")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDefaults.intialZoom)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleLocationPermission()
    }
}
