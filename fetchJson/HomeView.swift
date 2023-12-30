//
//  HomeView.swift
//  fetchJson
//
//  Created by magistra aptam on 26/11/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var network: NetworkManager
    private let adaptiveColumn = [
            GridItem(.adaptive(minimum: 150))
        ]
    @State var search:String = ""
    var body: some View {
        ScrollView{
            LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                ForEach(network.product) { item in
                    NavigationLink {
                        DetailView(productId: item.id)
                    } label: {
                        ItemCardComponent(itemImage: item.image, itemTitle: item.title, itemPrice: item.price)
                    }

                    
                }
            }
        }
        .searchable(text: $search)
        .navigationTitle("FakeStore")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItemGroup {
                NavigationLink {
                    CartView()
                } label: {
                    ZStack (alignment: .topTrailing){
                        Image(systemName: "cart")
                        ZStack {
                            Circle()
                                .frame(width: 18)
                                .foregroundColor(.red)
                            Text("\(network.cartItem.count)")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        }
                    }
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
