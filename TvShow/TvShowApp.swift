//
//  TvShowApp.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import SwiftUI

@main
struct TvShowApp: App {
    
    @State var isUnlocked = false
    
    var body: some Scene {
        WindowGroup {
            if isUnlocked {
                MainTVShowList(viewModel: TVShowsViewModel(dataSource: ShowsAPIImplementation()))
            } else {
                AuthenticationView(isUnlocked: $isUnlocked)
            }
            
        }
    }
    
}
