//
//  Place.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import Foundation
import CoreLocation
import SwiftData

@Model
class Place: Identifiable, ObservableObject {
    init(name: String, image: String, desc: String, latitude: Double, longitude: Double) {
        self.name = name
        self.image = image
        self.desc = desc
        self.latitude = latitude
        self.longitude = longitude
    }
    
    internal var id = UUID()
    let name: String
    var image: String
    var dateOfVisit: Date?
    let desc: String
    var comments: String?
    var unlocked: Bool = false
    var latitude: Double
    var longitude: Double
    var distance: Int?
    
    enum RootKeys: String, CodingKey {
        case name, images, description, latitude, longitude
    }
}
