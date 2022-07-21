import SwiftUI

struct RefreshButton: View {
    @EnvironmentObject private var viewModel: MapViewModel
    var body: some View {
        Button {
            viewModel.getApiData()
        } label: {
            Image("refresh")
        }.padding(.all)
            .frame(width: 63, height: 45)
            .background(Color(red: 0.41, green: 0.75, blue: 0.94))
            .cornerRadius(15)
    }
}

struct RefreshButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButton()
            .environmentObject(MapViewModel())
    }
}
