//
//  YoutubeSearchResponse.swift
//  MoviesProject
//
//  Created by Aisha Suanbekova Bakytjankyzy on 26.12.2024.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
