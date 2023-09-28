//
//  PlacesManager.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import Foundation

class PlacesManager {
    // static var places = [Place]()
    
    static func readJSONFile() -> [Place] {
        do {
            if let bundlePath = Bundle.main.path(forResource: "places", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                // Decoding the Product type from JSON data using JSONDecoder() class.
                let places = try JSONDecoder().decode([Place].self, from: jsonData)
                return places
            }
        } catch {
            print(error)
        }
        return []
    }
}
