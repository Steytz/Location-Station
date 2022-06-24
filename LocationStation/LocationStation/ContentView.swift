import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, interactionModes: .all ,showsUserLocation: true , annotationItems: viewModel.pins ) {pin
                in
                MapAnnotation(coordinate: pin.coordinate) {
                    CustomMapAnnotation( stationName: pin.name, id: pin.id)
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
                    VStack {
                        Text(viewModel.currentStation!.place.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                    }
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
                    .padding()
                    Spacer()
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
    let stationName: String
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
