//
//  Utils.swift
//  LocationStation
//
//  Created by Steyt on 26.06.22.
//

import Foundation

func roundTripDate(dateStr: String) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
         guard let date = formatter.date(from: dateStr) else {
             return nil
         }
        
         return getFormattedDate(date: date, format: "HH:mm")
     }

func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
}
