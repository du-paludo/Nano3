//
//  MainWidget.swift
//  MainWidget
//
//  Created by Eduardo Stefanel Paludo on 28/09/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), place: PlacesManager.getClosestLocation())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), place: PlacesManager.getClosestLocation())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), place: PlacesManager.getClosestLocation())]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let place: Place
}

struct MainWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image(entry.place.getImages().first!)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .overlay {
                    if !entry.place.isUnlocked() {
                        ZStack {
                            Color(.black)
                                .opacity(0.5)
                            VStack(spacing: 8) {
                                Image(systemName: "lock.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                Text("\(entry.place.getDistance())m")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
        }
        .padding(-16)
        .ignoresSafeArea()
    }
}

struct MainWidget: Widget {
    let kind: String = "MainWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MainWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MainWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        //.supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    MainWidget()
} timeline: {
    SimpleEntry(date: Date(), place: PlacesManager.getClosestLocation())
}
