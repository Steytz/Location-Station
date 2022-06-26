import MapKit
import SwiftUI

/*
 Locations:
 
 Barbarossaplatz
 lat: 50,92877624613752
 lon: 6,941698279051615
 
 
 Dom HBF
 lat: 50,94166063200314
 lon: 6,957480422702459
 
 Heumarkt
 lat: 50,93571844662832
 lon: 6,960726720674465
 */

struct Pin: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct Departure: Identifiable {
    var id: UUID
    let time: String
    let platform: String?
    let delay: Int?
    let transport: TTransport
    let agency: TAgency
}


enum MapDefaults {
    static let initialLocation = CLLocationCoordinate2D(latitude: 50.97682831527527, longitude: 6.968714720718723)
    static let intialZoom = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDefaults.initialLocation , span: MapDefaults.intialZoom)
    @Published var pins: Array<Pin> = []
    @Published var stations: Array<TBoardsElement> = []
    @Published var currentStation: TBoardsElement?
    @Published var showCurrentStationDepartures: Bool = false
    
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
            guard let location = locationManager.location else {return}
            region = MKCoordinateRegion(center: location.coordinate, span: MapDefaults.intialZoom)
            getApiData()
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationPermission()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.last {
            region = MKCoordinateRegion(center: location.coordinate, span: MapDefaults.intialZoom)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
    
    func getApiData() {
        guard let locationManager = locationManager else { return }
        guard let location = locationManager.location else {return}
        if(currentStation != nil) {currentStation = nil}
        
        let apiUrl = "https://transit.hereapi.com/v8/departures?in=\(location.coordinate.latitude),\(location.coordinate.longitude);r=500&apiKey=-kdXr7mAgI-3kd23Mw1ZJvv0YjqBoWQtNETJPQqjHEs&maxPlaces=10&maxPerBoard=50"
        guard let url = URL(string: apiUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {data,_,
            error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let departures = try JSONDecoder().decode(TDeparture.self, from: data)
                DispatchQueue.main.async {
                    self.stations = departures.boards
                    self.pins = []
                    departures.boards.forEach { item in
                        self.pins.append(Pin(id: item.place.id, name: item.place.name , coordinate: CLLocationCoordinate2D(latitude: item.place.location.lat, longitude: item.place.location.lng)))
                    }
                }
             
            }
            catch {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    func handlePinPress(id: String) {
        guard var element: TBoardsElement = stations.first(where: { $0.place.id == id }) else { return }
        element.departures.indices.forEach { element.departures[$0].id = UUID() }
        currentStation = element
    }
    
    func handleByTimeTest() {
        guard var element: TBoardsElement = stations.first(where: { $0.place.name == "Köln Heumarkt" }) else { return }
        currentStation = element
    }
    

}



