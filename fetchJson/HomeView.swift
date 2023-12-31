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
    @State var showDetailView: Bool = false
    @State var showCartView: Bool = false
    var body: some View {
        VStack {
            VStack{
                headerView(cart: network.cartItem.count)
                    .padding(.horizontal, 20)
                
            }
            ScrollView{
                VStack (spacing: 24){
                    BannerCarousel()
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
}

@ViewBuilder
func headerView(cart: Int) -> some View {
    HStack{
        Text("Discover your style")
            .font(.title2)
            .bold()
        Spacer()
        NavigationLink(destination: CartView()) {
            ZStack (alignment: .topTrailing){
                Image(systemName: "cart")
                    .font(.title2)
                ZStack {
                    Circle()
                        .frame(width: 18)
                        .foregroundColor(.red)
                    Text("\(cart)")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                }
            }

        }

        
    }
}

struct BannerCarousel: View {
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let banner = ["banner", "banner-2", "banner-3"]
    @State var currentPage = 0
    var body: some View {
        TabView(selection: $currentPage){
            ForEach(0..<banner.count){ index in
                Image(banner[index])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 353)
                    .clipped()
                    
                
            }
        }
        .frame(height: 154)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onReceive(timer) { _ in
            withAnimation {
                currentPage = (currentPage + 1)
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
