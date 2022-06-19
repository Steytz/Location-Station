import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .onAppear{
                   viewModel.checkIsLocationServiceOn()
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

