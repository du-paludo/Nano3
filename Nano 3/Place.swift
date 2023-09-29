//
//  Place.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import Foundation
import CoreLocation

class Place: Identifiable, ObservableObject {
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: RootKeys.self)
//        name = try values.decode(String.self, forKey: .name)
//        image = try values.decode(String.self, forKey: .images)
//        desc = try values.decode(String.self, forKey: .description)
//        latitude = try values.decode(Double.self, forKey: .latitude)
//        longitude = try values.decode(Double.self, forKey: .longitude)
//    }
    
    init(name: String, image: String, desc: String, latitude: Double, longitude: Double) {
        self.name = name
        self.image = image
        self.desc = desc
        self.latitude = latitude
        self.longitude = longitude
    }
    
    internal var id = UUID()
    private let name: String
    private var image: String
    private var dateOfVisit: Date = Date()
    private let desc: String
    private var comments: String?
    private var unlocked: Bool = false
    var latitude: Double
    var longitude: Double
    @Published private var distance: Int?
    
    enum RootKeys: String, CodingKey {
        case name, images, description, latitude, longitude
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getImages() -> String {
        return self.image
    }
    
//    public func addImage(image: String) {
//        self.images.append(image)
//    }
    
    public func getDateOfVisit() -> Date? {
        return self.dateOfVisit
    }
    
    public func setDateOfVisit(dateOfVisit: Date) {
        self.dateOfVisit = dateOfVisit
    }
    
    public func getDescription() -> String {
        return self.desc
    }
    
    public func getComments() -> String? {
        return self.comments
    }
    
    public func setComments(comments: String) {
        self.comments = comments
    }
    
    public func setUnlocked(unlocked: Bool) {
        self.unlocked = unlocked
    }
    
    public func isUnlocked() -> Bool {
        return unlocked
    }
    
//    public func getLocation() -> CLLocation {
//        return location
//    }
//
    public func getDistance() -> Int {
        if let dis = distance {
            return dis
        } else {
            return 0
        }
    }
    
    public func setDistance(distance: Int?) {
        self.distance = distance
    }
}
