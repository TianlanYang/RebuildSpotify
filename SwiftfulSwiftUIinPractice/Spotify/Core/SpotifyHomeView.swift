//
//  SpotifyHomeView.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 11/6/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    
    @Environment(\.router) var router
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    //: [Product] specifies the type of products as an array of Product objects.
    //= [] initializes products as an empty array.
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 将 header 放在 ScrollView 外部，确保它固定在顶部
                header
                
                ScrollView(.vertical) {
                    LazyVStack(spacing: 1) {
                        
                        VStack(spacing: 16){
                            recentsSection
                                .padding(.horizontal, 16)
                            
                            //.first就是第一个product
                            if let firstProduct = products.first{
                                newReleaseSection(firstProduct: firstProduct)
                                    .padding(.horizontal, 16)
                            }
                            
                            listRows
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .task{
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        do {
            currentUser = try await DataBaseHelper().getUsers().first
            products = try await Array(DataBaseHelper().getProducts().prefix(8))
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({$0.brand}))
            for brand in allBrands {
                if let unwrappedBrand = brand {
                    //let products = self.products.filter({ $0.brand == unwrappedBrand })
                    rows.append(ProductRow(title: unwrappedBrand.capitalized, products: products))
                }
            }
            productRows = rows
        } catch{
            
        }
    }
    
    private var header: some View {
        HStack(spacing: 0){
            ZStack{
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal){
                HStack(spacing: 8){
                    ForEach(Category.allCases, id: \.self){ category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized,
                                            isSelected: category == selectedCategory)
                        //点击之后将对应的selectedCategory值设为等于category
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        //.background(.blue)
        .padding(.leading, 8)
    }
    
    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product{
                SpotifyRecentCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton(.press) {
                    goToPlaylistView(product: product)
                }
            }
        }
    }
    
    private func goToPlaylistView(product: Product){
        guard let currentUser else {
            return
        }
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }
    
    private func newReleaseSection(firstProduct: Product) -> some View{
        SpotifyNewReleaseCell(
            imageName: firstProduct.firstImage,
            headline: firstProduct.brand,
            subheadline: firstProduct.category,
            title: firstProduct.title,
            subtitle: firstProduct.description,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                goToPlaylistView(product: firstProduct)
            }
        )
    }
    
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8){
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal){
                    HStack(alignment: .top, spacing: 16){
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton(.press) {
                                goToPlaylistView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyHomeView()
    }
}
