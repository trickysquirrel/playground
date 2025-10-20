//
//  MapViews.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 19/10/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // Melbourne CBD approximate coordinates
    private let melbourneCoordinate = CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631)

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        Map(position: .constant(.region(region))) {
            // Marker for Melbourne
            Marker("Melbourne", coordinate: melbourneCoordinate)
        }
        .mapStyle(.standard)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MapView()
}
