//
//  NetworkManager.swift
//  fetchJson
//
//  Created by magistra aptam on 26/11/23.
//

import Foundation

// MARK: - WelcomeElement
struct Product:Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

class NetworkManager: ObservableObject{
    @Published var product: [Product] = []
    @Published var productDetail: Product?
    
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
    
}
