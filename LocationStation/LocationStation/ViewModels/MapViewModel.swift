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


enum MapDefaults {
    static let initialLocation = CLLocationCoordinate2D(latitude: 50.97682831527527, longitude: 6.968714720718723)
    static let intialZoom = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}



final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDefaults.initialLocation , span: MapDefaults.intialZoom)
    @Published var pins: Array<TPin> = [] // Maybe not needed since we have station already
    @Published var stations: Array<TBoardsElement> = []
    @Published var currentStation: TBoardsElement?
    @Published var showCurrentStationDepartures: Bool = false
    @Published var currentListFilter: String = "time"
    
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
                        self.pins.append(TPin(id: item.place.id, name: item.place.name , coordinate: CLLocationCoordinate2D(latitude: item.place.location.lat, longitude: item.place.location.lng)))
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
        currentListFilter = "time"
        currentStation = element
    }
    
  /*
    func handleListSortByType() -> Array<TListSortedByItem> {
        var newArr: Array<TListSortedByItem> = []
        
        for departure in currentStation!.departures {
            if(!newArr.contains(where: { $0.sortName == departure.transport.mode })) {
                newArr.append(TListSortedByItem(id: UUID(), sortName: departure.transport.mode, departures: []  ))
            }
            let indexOfEle = newArr.firstIndex(where: { $0.sortName == departure.transport.mode } )
            
            if((indexOfEle) != nil) {
                newArr[indexOfEle!].departures.append(departure)
            }
        }
        return newArr
    }
    */
    
    /*
        func handleListSortByLine() -> Array<TListSortedByItem> {
            var newArr: Array<TListSortedByItem> = []
            
            for departure in currentStation!.departures {
                if(!newArr.contains(where: { $0.sortName == departure.transport.name })) {
                    newArr.append(TListSortedByItem(id: UUID(), sortName: departure.transport.name, departures: []  ))
                }
                let indexOfEle = newArr.firstIndex(where: { $0.sortName == departure.transport.name } )
                
                if((indexOfEle) != nil) {
                    newArr[indexOfEle!].departures.append(departure)
                }
            }
            return newArr
        }remove all these later */
    func handleListSortBy(filter: String) -> Array<TListSortedByItem> {
        var newArr: Array<TListSortedByItem> = []
        var indexOfEle: Array<TListSortedByItem>.Index?
        
        for departure in currentStation!.departures {
            switch filter {
            case "type":
                if(!newArr.contains(where: { $0.sortName == departure.transport.mode })) {
                    newArr.append(TListSortedByItem(id: UUID(), sortName: departure.transport.mode, departures: []  ))
                }
                indexOfEle = newArr.firstIndex(where: { $0.sortName == departure.transport.mode } )
            case "line":
                if(!newArr.contains(where: { $0.sortName == departure.transport.name })) {
                    newArr.append(TListSortedByItem(id: UUID(), sortName: departure.transport.name, departures: []  ))
                }
                indexOfEle = newArr.firstIndex(where: { $0.sortName == departure.transport.name } )
            default:
                break
            }
            
            if((indexOfEle) != nil) {
                newArr[indexOfEle!].departures.append(departure)
            }
        }
        return newArr
    }

}



