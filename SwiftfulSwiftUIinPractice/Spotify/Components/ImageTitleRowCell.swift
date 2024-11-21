//
//  ImageTitleRowCell.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 11/14/24.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constant.randomImage
    var title: String = "some texts"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
                .themeColor(isSelected: false)
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        ImageTitleRowCell()
    }
}
