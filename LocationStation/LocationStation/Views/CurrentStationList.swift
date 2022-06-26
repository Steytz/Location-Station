//
//  CurrentStationList.swift
//  LocationStation
//
//  Created by Steyt on 26.06.22.
//

import SwiftUI

struct CurrentStationList: View {
    @EnvironmentObject private var viewModel: MapViewModel
    var body: some View {
            HStack {
                Button(action: {
                    viewModel.handleByTimeTest()
                    
                }, label: {
                    Text("Zeiten")
                })
                
                Button(action: {print("Nach Typ")}, label: {
                    Text("Typ")
                })
                
                Button(action: {print("Linie")}, label: {
                    Text("Linie")
                })
            }
        
            List{
                ForEach(viewModel.currentStation!.departures) {departure in
                    HStack {
                        Text(departure.transport.name)
                        Text(departure.transport.headsign)
                        Text(roundTripDate(dateStr:departure.time)!)
                    }
                }
            }
  
    
       
    }
}

struct CurrentStationList_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStationList()
            .environmentObject(MapViewModel())
    }
}
