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
            VStack (spacing: 24){
//                Image("banner")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 353)
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

struct BannerCarousel: View {
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let banner = ["banner", "banner-2", "banner-3"]
    @State var currentPage = 0
    var body: some View {
        TabView(selection: $currentPage){
            ForEach(0..<banner.count){ index in
                Image(banner[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 353)
                    .clipped()
                    
                
            }
        }
        .frame(height: 200)
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
