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
                }
            }
                .ignoresSafeArea()
                .onAppear{
                   viewModel.checkIsLocationServiceOn()
            }
            
            if(viewModel.currentStation != nil) {
                VStack(spacing: 0) {
                    CurrentStationHeader()
                }
            }
          
        }.overlay(alignment: .bottom, content: {
            HStack(alignment: .center) {
                PlaceHolderView()
                Spacer()
                RefreshButton()
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
