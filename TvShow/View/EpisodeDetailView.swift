//
//  EpisodeDetailView.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct EpisodeDetailView: View {
    var episode: Episode
    var tvShowName: String
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center) {
                WebImage(url: URL(string: episode.portrait))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                VStack(alignment: .center, spacing: 10) {
                    Text(tvShowName)
                        .title4Style()
                    Text(episode.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("Season \(episode.season), Episode \(episode.number)")
                        .title4Style()
                }
                HTMLTextView(text: episode.summary, width: UIScreen.main.bounds.width - 80)
                    .padding(.all)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}
