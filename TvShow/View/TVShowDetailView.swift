//
//  TVShowDetailView.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct TVShowDetailView: View {
    
    @ObservedObject var viewModel: TVShowDetailViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: viewModel.show.portrait))
                    .resizable()
                    .scaledToFill()
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text(viewModel.show.name)
                            .mainTitleStyle()
                        HTMLTextView(text: viewModel.show.description, width: UIScreen.main.bounds.width - 80)
                        VStack(alignment: .leading) {
                            Text("Genres")
                                .subTitleStyle()
                            ScrollView(.horizontal,  showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(viewModel.show.genres, id: \.self) { item in
                                        Text(item)
                                            .chipStyle()
                                    }
                                    
                                }
                            }
                        }
                        .withBasicContainer()
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Schedule")
                                .subTitleStyle()
                            HStack {
                                Text("\(viewModel.show.timeSchedule) on")
                                    .bodyStyle()
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(viewModel.show.weekDaysSchedule, id: \.self) { item in
                                            Text(item)
                                                .multiColorChip()
                                        }
                                        
                                    }
                                }
                            }
                        }
                        .withBasicContainer()
                      
                    }
                    .padding(.horizontal)
                    EpisodesBySeasonListView(viewModel: viewModel)

                }
               
                
            }
            .onAppear {
                viewModel.fetchEpisodes()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct EpisodesBySeasonListView: View {
        
        @ObservedObject var viewModel: TVShowDetailViewModel
        let width = UIScreen.main.bounds.width
        
        var body: some View {
            VStack(alignment: .leading) {
                Group {
                    Text("Episodes")
                        .subTitleStyle()
                    
                    Picker("Season \(viewModel.selectedSeason)", selection: $viewModel.selectedSeason) {
                        ForEach(0..<viewModel.seasons, id: \.self) { item in
                            Text("Season \(item + 1)").tag(item + 1)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                }
                    .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.episodePerSeason[viewModel.selectedSeason] ?? [], id: \.id) { item in
                                NavigationLink(destination: EpisodeDetailView(episode: item, tvShowName: viewModel.show.name)) {
                                    VStack(alignment: .leading) {
                                        WebImage(url: URL(string: item.thumbnail))
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(10)
                                            .frame(height: width * 0.3)
                                        VStack(alignment: .leading) {
                                            Text("Episode \(item.number)")
                                                .subTitle3Style()
                                                .foregroundColor(.black.opacity(0.7))
                                            Text(item.name)
                                                .title4Style()
                                                .lineLimit(1)
                                            Button("Details") {}
                                            Spacer()
                                        }.padding(.horizontal, 4)
                                    }
                                    .frame(width: width * 0.55)
                                }
                            }
                        }
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    }
                    .padding(.leading)
                
            }
        }
    }
    
}
