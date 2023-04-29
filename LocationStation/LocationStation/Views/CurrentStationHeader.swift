import SwiftUI

struct CurrentStationHeader: View {
    @EnvironmentObject private var viewModel: MapViewModel
    
    var body: some View {
        VStack {
            if(viewModel.currentStation != nil){
                Button(action: {
                    withAnimation(.easeInOut) {
                        viewModel.showCurrentStationDepartures.toggle()
                    }
                }, label: {
                    Text(viewModel.currentStation!.place.name)
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
                                .rotationEffect(Angle(degrees: viewModel.showCurrentStationDepartures ? 180 : 0))
                        }

                })
            }
                
            if(viewModel.showCurrentStationDepartures) {
                CurrentStationList()
            }
                    
            }
            .background(Color(red: 0.41, green: 0.75, blue: 0.94))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
            .padding()
            Spacer()
    
        }
}

struct CurrentStationHeader_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStationHeader()
            .environmentObject(MapViewModel())
    }
}
