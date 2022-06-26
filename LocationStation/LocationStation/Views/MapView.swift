import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, interactionModes: .all ,showsUserLocation: true , annotationItems: viewModel.pins ) {pin
                in
                MapAnnotation(coordinate: pin.coordinate) {
                    CustomMapAnnotation( id: pin.id)
                        .onTapGesture {
                            viewModel.handlePinPress(id: pin.id)
                        }
                }
            }
                .ignoresSafeArea()
                .onAppear{
                   viewModel.checkIsLocationServiceOn()
            }
            
            if(viewModel.currentStation != nil) {
                VStack(spacing: 0) {
                    CurrentStationHeader(stationName: viewModel.currentStation!.place.name, departures: viewModel.currentStation!.departures, zeitenFunc: viewModel.handleByTimeTest)
                }
            }
          
        }.overlay(alignment: .bottom, content: {
            HStack(alignment: .center) {
                PlaceholderView()
                Spacer()
                RefreshButton(onPress: viewModel.getApiData)
                Spacer()
                InfoButton()
            }.padding(.horizontal, 14.0)
                
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(MapViewModel())
    }
}


struct RefreshButton: View {
    let onPress: () -> Void
    var body: some View {
        Button {
            onPress()
        } label: {
            Image("refresh")
        }.padding(.all)
            .frame(width: 63, height: 45)
            .background(Color(red: 0.41, green: 0.75, blue: 0.94))
            .cornerRadius(15)
    }
}

struct InfoButton: View {
    var body: some View {
        Button {
            print("Info")
        } label: {
            Text("i").foregroundColor(Color.black).bold().font(.largeTitle)
        }.frame(width: 50, height: 50)
            .background(Color(red: 0.41, green: 0.75, blue: 0.94))
            .cornerRadius(50)
    }
}

struct PlaceholderView: View {
    var body: some View {
        Rectangle().frame(width: 50, height: 50)
            .hidden()
    }
}

struct CustomMapAnnotation: View {
    let id: String
    
    var body: some View {
     Image("train-station")
            .resizable()
            .background(Color(red: 0.41, green: 0.75, blue: 0.94))
            .cornerRadius(15)
            .frame(width: 40, height: 40)
            .padding(10)
}
 }

struct CurrentStationHeader: View {
    let stationName: String
    let departures: [TDepartures]
    let zeitenFunc: () -> Void
    @State private var showDepartures:Bool = false
    
    var body: some View {
        VStack {
            
            Button(action: {
                withAnimation(.easeInOut) {
                showDepartures.toggle()
                }
            }, label: {
                Text(stationName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 7)
                    .overlay(alignment: .leading) {
                        Image("down-arrow")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.primary)
                            .padding()
                    }

            })
            
                
            if(showDepartures) {
                CurrentStationList(departures: departures, zeitenFunc: zeitenFunc)
            }
                    
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
            .padding()
            Spacer()
    
        }
    }

struct CurrentStationList: View {
    let departures: [TDepartures]
    let zeitenFunc: () -> Void
    var body: some View {
            HStack {
                Button(action: {
                    zeitenFunc()
                    
                }, label: {
                    Text("Zeiten")
                })
                
                Button(action: {print("Nach Typ")}, label: {
                    Text("Typ")
                })
                
                Button(action: {print("Linie")}, label: {
                    Text("Linie")
                })
            }
        
            List{
                ForEach(departures) {departure in
                    HStack {
                        Text(departure.transport.name)
                        Text(departure.transport.headsign)
                        Text(roundTripDate(dateStr:departure.time)!)
                    }
                }
            }
  
    
       
    }
}
