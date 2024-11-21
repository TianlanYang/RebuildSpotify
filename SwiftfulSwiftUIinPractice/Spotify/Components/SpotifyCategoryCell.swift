//
//  SpotifyCategoryCell.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 11/6/24.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String = "All"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColor(isSelected: isSelected)
            .cornerRadius(16)
    }
}

extension View {
    func themeColor(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        VStack(spacing: 40){
            SpotifyCategoryCell(title: "Title is here")
            SpotifyCategoryCell(title: "Title is here", isSelected: true)
            SpotifyCategoryCell(isSelected: true)
        }
    }
    
}
