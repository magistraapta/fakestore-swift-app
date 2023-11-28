//
//  NetworkManager.swift
//  fetchJson
//
//  Created by magistra aptam on 26/11/23.
//

import Foundation



class NetworkManager: ObservableObject{
    @Published var product: [Product] = []
    @Published var productDetail: Product?
    @Published var cartItem: [Product] = []
    
    init(){}
    
    
    func fetchData() async throws {
        guard let url = URL(string:  "https://fakestoreapi.com/products") else {
            throw URLError(.badURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        let decodeData = try decoder.decode([Product].self, from: data)
        self.product = decodeData
    }
    
    func getDetailProduct(id: Int) async{
        guard let url = URL(string: "https://fakestoreapi.com/products/\(id)") else {
            return
        }
        
        do {
            let urlRequest = URLRequest(url:url)
            let(data,response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decoder = JSONDecoder()
            
            let decodeDetail = try decoder.decode(Product.self, from: data)
            productDetail = decodeDetail
        } catch {
            print("error: \(error)")
        }
       
    }
    
    func addItemToCart(item: Product) {
        let item = Product(id: item.id, title: item.title, price: item.price, description: item.description, category: item.category, image: item.image, rating: item.rating)

        cartItem.append(item)
    }
    
    func deleteCartItem(index: IndexSet){
        cartItem.remove(atOffsets: index)
    }
}
