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
    
    var body: some View {
        NavigationLink {
            DetailedPlaceView(place: place, mapPosition: MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))
        } label: {
            VStack(spacing: 0) {
                Image(place.image)
                    .resizable()
                    .frame(height: 120)
                    .scaledToFit()
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 8, topTrailing: 8)))
                    .overlay {
                        if !place.unlocked {
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
                        Text(place.unlocked ? place.name : "???")
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.footnote)
                            .bold()
                        Spacer()
                        if !place.unlocked {
                            if let dis = place.distance {
                                Text("\(dis)m")
                                    .font(.caption2)
                                    .foregroundStyle(.blue)
                            } else {
                                Text("???m de você")
                                    .font(.caption2)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .shadow(radius: 4)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 160)
            }
        }
        .disabled(!place.unlocked)
        .onChange(of: locationManager.lastLocation) {
            place.distance = Int(CLLocation(latitude: place.latitude, longitude: place.longitude).distance(from: locationManager.lastLocation!))
            if place.distance! < 50 {
                place.dateOfVisit = Date.now
                place.unlocked = true
            }
        }
    }
}

//#Preview {
//    PlacesListItem()
//}
