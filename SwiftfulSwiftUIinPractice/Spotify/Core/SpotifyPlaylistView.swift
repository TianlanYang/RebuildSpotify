//
//  SpotifyPlaylistView.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 11/18/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    
    @Environment(\.router) var router
    
    var product: Product = .mock
    var user: User = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true
    
    var body: some View {
        ZStack{
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical){
                LazyVStack(spacing: 12){
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand!,
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150 ? true : false
                    }
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 70,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: {
                                
                            }
                        )
                        .padding(.leading, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            header
        }
        // .task是在视图创建时触发异步操作，task修饰符会在视图首次出现在屏幕上时执行任务。
        // 异步性保证了主线程不会因为数据加载被阻塞，提升用户界面响应速度。
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            products = try await DataBaseHelper().getProducts()
        } catch{
            
        }
    }
    
    private func goToPlaylistView(product: Product){
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: user)
        }
    }
    
    private var header: some View {
        ZStack{
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.spotifyBlack)
                .offset(y: showHeader ? 0 : -40)
                .opacity(showHeader ? 1 : 0)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showHeader ? Color.black.opacity(0.001) : Color.spotifyBlackGray.opacity(0.7))
                .clipShape(Circle())
                .onTapGesture {
                    router.dismissScreen()
                }
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.spotifyWhite)
        .animation(.smooth(duration: 0.2), value: showHeader)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    RouterView{ _ in
        SpotifyPlaylistView()
    }
}
