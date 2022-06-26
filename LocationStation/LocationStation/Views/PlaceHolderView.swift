import SwiftUI

struct PlaceHolderView: View {
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 50)
            .hidden()
    }
}

struct PlaceHolderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceHolderView()
            .environmentObject(MapViewModel())
    }
}
