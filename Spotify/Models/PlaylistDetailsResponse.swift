//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/28/21.
//

import Foundation


struct PlaylistDetailsResponse : Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTrackResponse
}


struct PlaylistTrackResponse: Codable {
    let items: [PlaylistItem]
}


struct PlaylistItem: Codable {
    let track: AudioTrack
}
