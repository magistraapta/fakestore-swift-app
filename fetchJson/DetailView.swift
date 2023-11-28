//
//  DetailView.swift
//  fetchJson
//
//  Created by magistra aptam on 27/11/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var network: NetworkManager
    @State var productId: Int
    var body: some View {
        ScrollView(.vertical) {
            if let product = network.productDetail {
                VStack(alignment:.leading, spacing: 12){
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 327, height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(product.title)
                        .font(.system(size: 24))
                        .bold()
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(describing: product.rating))
                    }
                    Text(product.description)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("Add to cart")
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    }

                }
                .padding()
                
            } else {
                ProgressView("Loading...")
                    .task {
                        await network.getDetailProduct(id: productId)
                    }
            }
            
        }
        .task {
            await network.getDetailProduct(id: productId)
        }
        .refreshable {
            await network.getDetailProduct(id: productId)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(productId: 4)
                .environmentObject(NetworkManager())
        }
    }
}
