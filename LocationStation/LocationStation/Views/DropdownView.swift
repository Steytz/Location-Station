//
//  DropdownView.swift
//  LocationStation
//
//  Created by Steyt on 28.06.22.
//

import SwiftUI

struct DropdownView: View {
    let label: String
    let innerElements: Array<TDepartures>
    @State private var isOpen: Bool = false
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut) {
                    isOpen.toggle()
                }
            }, label: {
                Text(label)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 7)
                    .overlay(alignment: .trailing) {
                        Image("arrow-down-white")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.primary)
                            .padding()
                            .padding(.horizontal, 15)
                            .rotationEffect(Angle(degrees: isOpen ? 180 : 0))
                    }

            }).background(Color(red: 0.22, green: 0.33, blue: 0.40))
                .cornerRadius(15)
                
            
            if(isOpen) {
                VStack {
                    ForEach(innerElements) {departure in
                        RowView(name: departure.transport.name, headsign: departure.transport.headsign, time: roundTripDate(dateStr:departure.time)!)
                    }
                }
            
            }
        }
    }
}
