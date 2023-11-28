//
//  CartView.swift
//  fetchJson
//
//  Created by magistra aptam on 28/11/23.
//

import SwiftUI

struct CartView: View {
//    @StateObject var cartViewModel = CartViewModel()
    @EnvironmentObject var network: NetworkManager
    var body: some View {
        List {
            ForEach(network.cartItem){item in
                HStack{
                    AsyncImage(url: URL(string: item.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .background(Color.gray.opacity(0.4))
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                    Text("\(item.title)")
                }
            }
            .onDelete(perform: network.deleteCartItem)
        }
        .navigationTitle("Cart")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartView()
                .environmentObject(NetworkManager())
        }
    }
}
