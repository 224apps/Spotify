//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/25/21.
//

import Foundation


struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}

