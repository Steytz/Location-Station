import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, interactionModes: .all ,showsUserLocation: true , annotationItems: viewModel.pins ) { pin
                in
                MapAnnotation(coordinate: pin.coordinate) {
                    CustomMapAnnotation( id: pin.id)
                        .onTapGesture {
                            viewModel.handlePinPress(id: pin.id)
                        }

                        .scaleEffect(viewModel.currentStation?.place.id == pin.id ? 1.3 : 1)
                        .shadow(radius: 10)
                }
            }
                .ignoresSafeArea()
                .onAppear{
                   viewModel.checkIsLocationServiceOn()
            }
            
            
                VStack(spacing: 0) {
                    if(viewModel.currentStation != nil) { CurrentStationHeader() }
                    Spacer()
                    HStack(alignment: .center) {
                        PlaceHolderView()
                        Spacer()
                        RefreshButton()
                        Spacer()
                        InfoButton()
                    }.padding(.horizontal, 14.0)
                
            }
          
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(MapViewModel())
    }
}
