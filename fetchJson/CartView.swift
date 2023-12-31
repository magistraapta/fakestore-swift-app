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
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
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
                Spacer()
                
            }
            .padding(.horizontal, 15)
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
            .listStyle(.plain)
            .navigationBarBackButtonHidden(true)
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
        .padding(.horizontal,15)
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
