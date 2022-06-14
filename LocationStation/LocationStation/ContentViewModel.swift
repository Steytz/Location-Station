import MapKit

enum MapDefaults {
    static let initialLocation = CLLocationCoordinate2D(latitude: 50.97682831527527, longitude: 6.968714720718723)
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
            getApiData(lat:String(region.center.latitude), lon: String(region.center.longitude))
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationPermission()
    }
    
    func getApiData(lat: String, lon: String) {
        let apiUrl = "https://transit.hereapi.com/v8/departures?in=\(lat),\(lon);r=500&apiKey=-kdXr7mAgI-3kd23Mw1ZJvv0YjqBoWQtNETJPQqjHEs"
        guard let url = URL(string: apiUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {data,_,
            error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let departures = try JSONDecoder().decode(TDeparture.self, from: data)
                departures.boards.forEach { i in
                    print(i.place.name)
                }
            }
            catch {
                print(error)
            }
            
        }
        
        task.resume()
    }
}
