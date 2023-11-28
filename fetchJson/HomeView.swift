//
//  HomeView.swift
//  fetchJson
//
//  Created by magistra aptam on 26/11/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var network: NetworkManager
    var body: some View {
        List{
            ForEach(network.product){item in
                NavigationLink {
                    DetailView(productId: item.id)
                } label: {
                    HStack {
                        Text("\(item.title)")
                        Spacer()
                        Text("\(item.price)")
                            .foregroundColor(Color(.purple))
                    }
                }
            }
        }
        .navigationTitle("Item List")
        .toolbar{
            ToolbarItemGroup {
                NavigationLink {
                    CartView()
                } label: {
                    Image(systemName: "cart")
                }

            }
        }
        .onAppear{
            Task{
                do{
                    try await network.fetchData()
                } catch{
                    print(error)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .environmentObject(NetworkManager())
        }
        
    }
}
