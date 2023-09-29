//
//  PlacesList.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI

struct PlacesList: View {
    let selectedFilter: Filter
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(PlacesManager.places) { place in
                if !(selectedFilter == .notUnlocked && place.isUnlocked()) {
                    PlacesListItem(place: place)
                }
            }
        }
    }
}

#Preview {
    PlacesList(selectedFilter: .all)
}
