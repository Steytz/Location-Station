import SwiftUI

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

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton()
            .environmentObject(MapViewModel())
    }
}
