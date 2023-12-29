//
//  ItemCardComponent.swift
//  fetchJson
//
//  Created by Magistra Apta on 28/12/23.
//

import SwiftUI

struct ItemCardComponent: View {
    @State var itemImage: String
    @State var itemTitle: String
    @State var itemPrice: Double
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: itemImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:100)
                } placeholder: {
                    Rectangle()
                        .frame(width: 150, height: 200)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .cornerRadius(12)
            }
            VStack (alignment: .leading, spacing: 8){
                Text(itemTitle)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Text("$\(itemPrice)")
                    .foregroundColor(.black)
            }
            .padding()
            
        }
        .frame(maxWidth: 200)

    }
}

struct ItemCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardComponent(itemImage: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg", itemTitle:  "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet", itemPrice: 109.95)
    }
}
