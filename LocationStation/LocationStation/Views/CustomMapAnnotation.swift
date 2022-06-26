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
     Image("train-station")
            .resizable()
            .background(Color(red: 0.41, green: 0.75, blue: 0.94))
            .cornerRadius(15)
            .frame(width: 40, height: 40)
            .padding(10)
}
}

struct CustomMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapAnnotation(id: "Something")
            .environmentObject(MapViewModel())
    }
}
