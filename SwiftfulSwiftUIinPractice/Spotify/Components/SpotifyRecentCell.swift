//
//  SpotifyRecentCell.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 11/7/24.
//

import SwiftUI

struct SpotifyRecentCell: View {
    
    var imageName: String = Constant.randomImage
    var title: String = "Some random title Some random things"
    
    var body: some View {
        HStack(spacing: 16){
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
                //.background(.green)
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColor(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        VStack{
            HStack{
                SpotifyRecentCell()
                SpotifyRecentCell()
            }
            HStack{
                SpotifyRecentCell()
                SpotifyRecentCell()
            }
        }
    }
}
