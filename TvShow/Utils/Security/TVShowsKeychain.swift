//
//  TVShowsKeychain.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 21/06/23.
//

import Foundation
import KeychainAccess

struct TVShowsKeychain {
    static private let keychain = Keychain(service: "com.pe.rjulcaa.tvshows")
    
    static private let pinKey = "PIN_KEY"
    static func getPIN() -> String? {
        return keychain[pinKey]
    }
    
    static func savePIN(_ pin: String) {
        keychain[pinKey] = pin
    }
    
}
