//
//  HomeView.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI
import CoreData

enum Filter: String, CaseIterable, Identifiable {
    case all, notUnlocked
    var id: Self { self }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
} ()

struct HomeView: View {
    @State private var selectedFilter: Filter = .all
    @StateObject var locationManager = LocationManager()
//    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    
//    private var items: FetchedResults<Place>

    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
        
        NavigationStack {
            VStack(alignment: .leading) {
                Picker("Filter", selection: $selectedFilter) {
                    Text("Todos").tag(Filter.all)
                    Text("Não desbloqueados").tag(Filter.notUnlocked)
                }
                .pickerStyle(.segmented)
                //.padding(.horizontal, 36)
                Text("Meus lugares")
                    .font(.largeTitle)
                    .bold()
                PlacesList(selectedFilter: selectedFilter)
                Spacer()
            }
            .padding(16)
        }
        .navigationTitle("Lugares")
        .onAppear {
            locationManager.requestAuthorization()
        }
        .environmentObject(locationManager)
    }
    
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

#Preview {
    HomeView()
//    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

