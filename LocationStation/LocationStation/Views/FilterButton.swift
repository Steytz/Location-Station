//
//  FilterButton.swift
//  LocationStation
//
//  Created by Steyt on 21.07.22.
//

import SwiftUI

struct FilterButton: View {
    @EnvironmentObject private var viewModel: MapViewModel
    let buttonText: String
    let filterValue: String
    var body: some View {
        Button(action: {
            viewModel.currentListFilter = filterValue
            
        }, label: {
            Text(buttonText)
                .fontWeight( viewModel.currentListFilter == filterValue ? .bold : .regular)
                .scaleEffect(viewModel.currentListFilter == filterValue ? 1.1 : 1)
                .foregroundColor(.black)
        }).padding(.horizontal)
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(buttonText: "time", filterValue: "Time")
            .environmentObject(MapViewModel())
    }
}
