//
//  HomeView.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import SwiftUI

enum Filter: String, CaseIterable, Identifiable {
    case all, notUnlocked
    var id: Self { self }
}

struct HomeView: View {
    @State private var selectedFilter: Filter = .all
    @StateObject var locationManager = LocationManager()

    var body: some View {
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
}

#Preview {
    HomeView()
}
