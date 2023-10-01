//
//  PlacesList.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI
import SwiftData

struct PlacesList: View {
    let selectedFilter: Filter
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    @StateObject var locationManager = LocationManager()
    @Environment(\.modelContext) private var context
    @Query(sort: \Place.distance, order: .forward) var places: [Place]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(places) { place in
                if !(selectedFilter == .notUnlocked && place.unlocked) {
                    PlacesListItem(place: place)
                }
            }
        }
    }
}

#Preview {
    PlacesList(selectedFilter: .all)
}
