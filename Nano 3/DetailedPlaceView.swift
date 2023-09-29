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
    @State var comment: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(place.getImages().first!)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                HStack {
                    Text("Data de visita")
                        .font(.body)
                        .bold()
                        .foregroundStyle(.black)
                    Spacer()
                    Text(dateToString(place.getDateOfVisit()!))
                }
                
                Divider()
                
                Text(place.getDescription())
                    .font(.callout)
                    .foregroundStyle(.black)
                
                Divider()
                
                Map(position: $mapPosition) {
                    UserAnnotation()
                    Marker(place.getName(), coordinate: place.getLocation().coordinate)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(maxWidth: .infinity, minHeight: 240)
                
                Divider()
                
                Text("Comentários")
                    .font(.body)
                    .bold()
                TextField("Escreva algo legal sobre o lugar", text: $comment, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(4...5)
                    //.submitLabel(.done)
            }
            .padding(24)
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(place.getName())
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
