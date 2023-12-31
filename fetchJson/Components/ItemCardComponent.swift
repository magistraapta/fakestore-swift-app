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
    @State var itemPrice: Double = 0.0
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: itemImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150, alignment: .top)
                    .clipped()
                    .cornerRadius(12)
                } placeholder: {
                    Rectangle()
                        .frame(width: 150, height: 200)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .cornerRadius(12)
            }
            VStack (alignment: .leading, spacing: 8){
                Text(itemTitle)
                    .foregroundColor(.black)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                    
                Text("$\(ridZero(result: itemPrice))")
                    .foregroundColor(.black)
            }
            .frame( width: 150,height: 80)
            
        }
        .frame(maxWidth: 200)

    }
    
    func ridZero(result: Double) -> String{
        let value = String(format: "%g", result)
        return value
    }
}

struct ItemCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardComponent(itemImage: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg", itemTitle:  "John Hardy W", itemPrice: 109.95)
    }
}
