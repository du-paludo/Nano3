//
//  DetailedPlaceView.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI
import MapKit

struct DetailedPlaceView: View {
    let place: Place
    @State var mapPosition: MapCameraPosition
    @State var comments: String = ""
    @FocusState var isFocused: Bool
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(place.image)
                    .resizable()
                    .frame(height: 240)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                HStack {
                    Text("Data de visita")
                        .font(.body)
                        .bold()
                    Spacer()
                    if let date = place.dateOfVisit {
                        Text(dateToString(date))
                    }
                }
                
                Divider()
                
                Text(place.desc)
                    .font(.callout)
                
                Divider()
                
                Map(position: $mapPosition) {
                    UserAnnotation()
                    Marker(place.name, coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude))
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(maxWidth: .infinity, minHeight: 240)
                
                Divider()
                
                Text("Comentários")
                    .font(.body)
                    .bold()
                TextField("Escreva algo legal sobre o lugar", text: $comments, axis: .vertical)
                    .focused($isFocused)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(4...5)
                    .onChange(of: isFocused) {
                        do {
                            place.comments = comments
                            try context.save()
                        } catch {}
                    }
                    //.submitLabel(.done)
            }
            .padding(24)
        }
        .onAppear {
            if let x = place.comments {
                comments = x
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(place.name)
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "pt_BR_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
}

//#Preview {
//    DetailedPlaceView()
//}
