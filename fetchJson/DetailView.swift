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
    @Environment(\.presentationMode) var isPresented
    var body: some View {
        ScrollView(.vertical) {
            if let product = network.productDetail {
                VStack( alignment: .leading,spacing: 12){
                Button {
                    isPresented.wrappedValue.dismiss()
                } label: {
                    ZStack{
                        Rectangle()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36)
                            .cornerRadius(12)
                            .background()
                            .foregroundColor(Color.gray.opacity(0.3))
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.black)

                    }
                                
                }

                VStack {
                    AsyncImage(url: URL(string: product.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 327, height: 200)
                        } placeholder: {
                            ImageSkeleton()
                    }
                }
                .frame(maxWidth: .infinity)
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
                        network.addItemToCart(item: product)
                        print("clicked")
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
                VStack (alignment: .leading){
                    ImageSkeleton()
                    TextSkeleton()
                }
                .padding(.horizontal,15)
                    .task {
                        await network.getDetailProduct(id: productId)
                    }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await network.getDetailProduct(id: productId)
        }
        .refreshable {
            await network.getDetailProduct(id: productId)
        }
    }
}

private struct HeaderView: View {
    var body: some View{
        HStack{
            Image(systemName: "chevron.left")
                .font(.title2)
            Spacer()
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(productId: 1)
                .environmentObject(NetworkManager())
        }
    }
}
