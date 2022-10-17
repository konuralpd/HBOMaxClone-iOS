//
//  YoutubeResponse.swift
//  HBOMaxClone
//
//  Created by Mac on 17.10.2022.
//

import Foundation


struct YoutubeResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: VideoElementID
}

struct VideoElementID: Codable {
    let kind: String
    let videoId: String
}
