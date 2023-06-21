//
//  TVShowsView.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct TVShowsView: View {
    
    @ObservedObject var viewModel: TVShowsViewModel
    @Environment(\.isSearching) private var isSearching
        
    init(viewModel: TVShowsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            if isSearching {
                SearchTVShowsListView(width: geometry.size.width, viewModel: viewModel)
            } else {
                TVShowsListView(width: geometry.size.width, viewModel: viewModel)
            }
        }
        
    }
    
}

struct TVShowsListView: View {
    let width: CGFloat
    @ObservedObject var viewModel: TVShowsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.shows) { item in
                NavigationLink {
                    TVShowDetailView(viewModel: TVShowDetailViewModel(show: item, dataSource: viewModel.dataSource))
                } label: {
                    HStack(alignment: .top, spacing: 10) {
                        WebImage(url: URL(string: item.thumbnail))
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(5)
                            .frame(width: width * 0.2)
                        VStack {
                            Spacer()
                            Text(item.name)
                                .lineLimit(2)
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                    
                    .onAppear {
                        viewModel.loadMoreContent(currentItem: item)
                    }
                }
                
            }
            
        }
    }
}

struct SearchTVShowsListView: View {
    let width: CGFloat
    @ObservedObject var viewModel: TVShowsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.searchShowsResult) { item in
                NavigationLink {
                    TVShowDetailView(viewModel: TVShowDetailViewModel(show: item, dataSource: viewModel.dataSource))
                } label: {
                    HStack(alignment: .top, spacing: 10) {
                        WebImage(url: URL(string: item.thumbnail))
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(5)
                            .frame(width: width * 0.2)
                        VStack {
                            Spacer()
                            Text(item.name)
                                .lineLimit(2)
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                }
                
            }
            
        }
    }
}


struct MainTVShowList: View {
    @ObservedObject var viewModel: TVShowsViewModel
    
    
    var body: some View {
        NavigationView {
            TVShowsView(viewModel: viewModel)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                .navigationTitle("TV Shows")
        }
        .onAppear {
            viewModel.fetchShows()
        }
    }
}
