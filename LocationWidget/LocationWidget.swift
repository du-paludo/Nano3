//
//  LocationWidget.swift
//  LocationWidget
//
//  Created by Eduardo Stefanel Paludo on 01/10/23.
//

import WidgetKit
import SwiftUI
import SwiftData
import CoreLocation

struct Provider: TimelineProvider {
    @MainActor
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), places: getPlaces())
    }
    
    @MainActor
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), places: getPlaces())
        completion(entry)
    }
    
    @MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: .now, places: getPlaces())], policy: .after(.now.advanced(by: 5)))
        completion(timeline)
    }
    
    @MainActor
    func getPlaces() -> [Place] {
        guard let modelContainer = try? ModelContainer(for: Place.self) else {
            return []
        }
        let descriptor = FetchDescriptor<Place>(predicate: #Predicate { place in
            place.unlocked == false
        }, sortBy: [SortDescriptor<Place>(\.distance, order: .forward)])
        let places = try? modelContainer.mainContext.fetch(descriptor)
        print(places)
        return places ?? []
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let places: [Place]
}

struct LocationWidgetEntryView : View {
    var entry: Provider.Entry
//    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            Image(entry.places.first?.image ?? "")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .overlay {
//                    if (!entry.places.first?.unlocked ?? false) {
                        ZStack {
                            Color(.black)
                                .opacity(0.5)
                            VStack(spacing: 8) {
                                Image(systemName: "lock.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                Text("\(entry.places.first?.distance! ?? 0) m")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
//                        }
                    }
                }
        }
//        .onChange(of: locationManager.lastLocation) {
//            entry.places.first?.distance! = Int(CLLocation(latitude: entry.places.first!.latitude, longitude: entry.places.first!.longitude).distance(from: locationManager.lastLocation!))
//            if (entry.places.first!.distance!) < 50 {
//                entry.places.first?.dateOfVisit = Date.now
//                entry.places.first?.unlocked = true
//            }
//        }
        .padding(-16)
        .ignoresSafeArea()
    }
}

struct LocationWidget: Widget {
    let kind: String = "LocationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LocationWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LocationWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    LocationWidget()
} timeline: {
    SimpleEntry(date: .now, places: [])
    SimpleEntry(date: .now, places: [])
}
