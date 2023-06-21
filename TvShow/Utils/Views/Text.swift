//
//  Text.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import SwiftUI

extension Text {
    func mainTitleStyle() -> some View {
        self.font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }
    
    func subTitleStyle() -> some View {
        self.font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }
    
    func subTitle3Style() -> some View {
        self.font(.system(size: 13))
            .fontWeight(.medium)
    }
    
    func bodyStyle() -> some View {
        self.font(.body)
            .fontWeight(.regular)
            .foregroundColor(.black)
    }
    
    func title4Style() -> some View {
        self.font(.system(size: 16))
            .fontWeight(.medium)
            .foregroundColor(.black)
    }
    
    func chipStyle() -> some View {
        self.font(.caption2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 6)
            .background(Color.gray)
            .cornerRadius(10)
    }
    
    func multiColorChip() -> some View {
        return self.font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 6)
                .background(Color.black)
                .cornerRadius(5)
    }
}

extension View {
    func withBasicContainer() -> some View {
        self.padding(8)
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
}
