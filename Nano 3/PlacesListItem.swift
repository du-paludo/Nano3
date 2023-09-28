//
//  PlacesListItem.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI
import MapKit

struct PlacesListItem: View {
    let place: Place
    @EnvironmentObject var locationManager: LocationManager
    
//    var userLatitude: String {
//        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
//    }
//
//    var userLongitude: String {
//        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
//    }
    
    var distance: Double? {
        if let userLocation = locationManager.lastLocation {
            return place.getLocation().distance(from: userLocation)
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationLink {
            DetailedPlaceView(place: place, mapPosition: MapCameraPosition.region(MKCoordinateRegion(center: place.getLocation().coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))
        } label: {
            VStack(spacing: 0) {
                Image(place.getImages().first!)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 120)
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 8, topTrailing: 8)))
                    .overlay {
                        if !place.isUnlocked() {
                            ZStack {
                                Color(.black)
                                    .opacity(0.5)
                                Image(systemName: "lock.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 8, topTrailing: 8)))
                VStack(alignment: .leading) {
                    HStack {
                        Text(place.isUnlocked() ? place.getName() : "???")
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.footnote)
                            .bold()
                        Spacer()
                        if !place.isUnlocked() {
                            if let dis = distance {
                                Text("\(Int(dis))m de você")
                                    .font(.caption2)
                            } else {
                                Text("???m de você")
                                    .font(.caption2)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            }
            .onChange(of: distance) {
                if let dis = distance {
                    if dis < 40 {
                        place.setUnlocked(unlocked: true)
                    }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .shadow(radius: 4)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 160)
            }
        }
    }
}

//#Preview {
//    PlacesListItem()
//}
