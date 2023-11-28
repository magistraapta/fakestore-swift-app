//
//  ContentView.swift
//  fetchJson
//
//  Created by magistra aptam on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NetworkManager())
    }
}
