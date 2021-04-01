//
//  Playlist.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    
}
