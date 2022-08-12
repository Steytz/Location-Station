import SwiftUI

struct CurrentStationList: View {
    @EnvironmentObject private var viewModel: MapViewModel
    var body: some View {
        if(viewModel.currentStation != nil){
            VStack {
            HStack {
                FilterButton(buttonText: "Zeiten", filterValue: "time")
                FilterButton(buttonText: "Typ", filterValue: "type")
                FilterButton(buttonText: "Linie", filterValue: "line")
            }
                ScrollView {
                    switch viewModel.currentListFilter {
                    case "time":
                            ForEach(viewModel.currentStation!.departures) {departure in
                                RowView(name: departure.transport.name, headsign: departure.transport.headsign, time: roundTripDate(dateStr:departure.time)!)
                            }
                    case "type":
                                ForEach(viewModel.handleListSortBy(filter: "type")) {item in
                                    DropdownView(label: transportNameMap[item.sortName] ?? item.sortName, innerElements: item.departures)
                            }
                       
                    case "line":
                            ForEach(viewModel.handleListSortBy(filter: "line")) {item in
                                DropdownView(label: item.sortName, innerElements: item.departures)
                            }
                    default:
                        Text("Something else")
                    }
                }.padding()
            }.background(Color(red: 0.41, green: 0.75, blue: 0.94))
        }
    }
}

struct CurrentStationList_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStationList()
            .environmentObject(MapViewModel())
    }
}
