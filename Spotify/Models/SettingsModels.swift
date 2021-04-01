//
//  SettingsModels.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/25/21.
//

import Foundation


struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}



