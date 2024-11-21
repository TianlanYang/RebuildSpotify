//
//  Product.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 11/5/24.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable{
    let id: Int
    let title, description: String
    let category: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand: String?
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constant.randomImage
    }
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "This is some mock product description that goes here",
            category: "Electronic Devices",
            price: 999,
            discountPercentage: 15,
            rating: 4.5,
            stock: 50,
            brand: "Apple",
            images: [Constant.randomImage,Constant.randomImage,Constant.randomImage],
            thumbnail: Constant.randomImage
        )
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}




