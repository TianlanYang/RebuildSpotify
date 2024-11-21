//
//  ImageLoaderView.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 10/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var urlString: String = "https://picsum.photos/600/600"
    
    var body: some View {
        
        Rectangle()
            .opacity(0.001)
            .overlay(
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false)
            )
            .clipped()
            
        
        
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
