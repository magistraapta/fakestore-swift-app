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
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50, alignment: .top)
                            .background(Color.gray.opacity(0.4))
                            .clipped()
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
        .navigationBarTitleDisplayMode(.inline)
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
