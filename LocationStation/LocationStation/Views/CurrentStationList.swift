import SwiftUI

struct CurrentStationList: View {
    @EnvironmentObject private var viewModel: MapViewModel
    var body: some View {
        if(viewModel.currentStation != nil){
            HStack {
                Button(action: {
                    viewModel.currentListFilter = "time"
                    
                }, label: {
                    Text("Zeiten")
                })
                
                Button(action: {
                    viewModel.currentListFilter = "type"
                }, label: {
                    Text("Typ")
                })
                
                Button(action: {
                    viewModel.currentListFilter = "line"
                }, label: {
                    Text("Linie")
                })
            }
            
            switch viewModel.currentListFilter {
            case "time":
                List{
                    ForEach(viewModel.currentStation!.departures) {departure in
                        HStack {
                            Text(departure.transport.name)
                            Text(departure.transport.headsign)
                            Text(roundTripDate(dateStr:departure.time)!)
                        }
                    }
                }
            case "type":
                VStack {
                    ScrollView {
                    ForEach(viewModel.handleListSortByType()) {item in
                        Text(item.sortName)
                        ForEach(item.departures) {departure in
                            HStack {
                                Text(departure.transport.name)
                                Text(departure.transport.headsign)
                                Text(roundTripDate(dateStr:departure.time)!)
                            }
                        }
                    }
                }
                }
                
            case "line":
                VStack {
                    ScrollView {
                    ForEach(viewModel.handleListSortByLine()) {item in
                        Text(item.sortName)
                        ForEach(item.departures) {departure in
                            HStack {
                                Text(departure.transport.name)
                                Text(departure.transport.headsign)
                                Text(roundTripDate(dateStr:departure.time)!)
                            }
                        }
                    }
                }
                }
            default:
                Text("Something else")
            }
        
      
  
    
        }
    }
}

struct CurrentStationList_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStationList()
            .environmentObject(MapViewModel())
    }
}
