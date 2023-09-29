//
//  Place.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import Foundation
import CoreLocation

//class Place: Decodable, Identifiable {
class Place: NSObject, Identifiable, ObservableObject, NSCoding {
    func encode(with coder: NSCoder) {
        <#code#>
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        images = coder.decodeObject(forKey: "images") as! [String]
        dateOfVisit = coder.decodeObject(forKey: "dateOfVisit") as! Date
        name = coder.decodeObject(forKey: "desc") as! String
        desc = coder.decodeObject(forKey: "comments") as! String
        unlocked = coder.decodeObject(forKey: "unlocked") as! Bool
    }
    
    internal var id = UUID()
    private let name: String
    private var images: [String]
    private var dateOfVisit: Date = Date()
    private let desc: String
    private var comments: String?
    private var unlocked: Bool = false
    private var location: CLLocation
    @Published private var distance: Int?
    
    enum RootKeys: String, CodingKey {
        case name, images, description, latitude, longitude
    }
    
    //    required init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: RootKeys.self)
    //        name = try values.decode(String.self, forKey: .name)
    //        images = try values.decode([String].self, forKey: .images)
    //        description = try values.decode(String.self, forKey: .description)
    //        let latitude = try values.decode(Double.self, forKey: .latitude)
    //        let longitude = try values.decode(Double.self, forKey: .longitude)
    //        location = CLLocation(latitude: latitude, longitude: longitude)
    //    }
    
    init(name: String, images: [String], description: String, latitude: Double, longitude: Double) {
        self.name = name
        self.images = images
        self.description = description
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getImages() -> [String] {
        return self.images
    }
    
    public func addImage(image: String) {
        self.images.append(image)
    }
    
    public func getDateOfVisit() -> Date? {
        return self.dateOfVisit
    }
    
    public func setDateOfVisit(dateOfVisit: Date) {
        self.dateOfVisit = dateOfVisit
    }
    
    public func getDescription() -> String {
        return self.description
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
    
    public func getLocation() -> CLLocation {
        return location
    }
    
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
