//
//  RowView.swift
//  LocationStation
//
//  Created by Steyt on 28.06.22.
//

import SwiftUI

struct RowView: View {
    let name: String
    let headsign: String
    let time: String
    var body: some View {
        HStack {
            Text(name)
            Text(headsign)
            Text(time)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .cornerRadius(15)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(name: "dsfs", headsign: "fds", time: "fsvs")
            .environmentObject(MapViewModel())
    }
}
