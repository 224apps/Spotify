//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/25/21.
//

import Foundation



struct NewReleasesResponse: Codable {
    let albums: AlbumsReponse
}

struct AlbumsReponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    let images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}
