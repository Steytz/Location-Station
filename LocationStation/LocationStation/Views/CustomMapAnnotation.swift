//
//  CustomMapAnnotation.swift
//  LocationStation
//
//  Created by Steyt on 26.06.22.
//

import SwiftUI

struct CustomMapAnnotation: View {
    let id: String
    
    var body: some View {
        VStack {
                Image("train-station")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 35, height: 35)

        }
        .frame(width: 50, height: 50)
        .background(Color(red: 0.41, green: 0.75, blue: 0.94))
            .cornerRadius(50)

}
}

struct CustomMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapAnnotation(id: "Something")
            .environmentObject(MapViewModel())
    }
}
