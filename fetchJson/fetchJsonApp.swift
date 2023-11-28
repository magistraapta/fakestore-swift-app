//
//  fetchJsonApp.swift
//  fetchJson
//
//  Created by magistra aptam on 26/11/23.
//

import SwiftUI

@main
struct fetchJsonApp: App {
    var network = NetworkManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
