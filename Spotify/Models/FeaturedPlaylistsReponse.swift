//
//  FeaturedPlaylistsReponse.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/25/21.
//

import Foundation


struct FeaturedPlaylistsReponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
    
}
