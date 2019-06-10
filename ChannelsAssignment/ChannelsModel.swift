//
//  ChannelsModel.swift
//  ChannelsAssignment
//
//  Created by Suraj on 10/06/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import Foundation

struct ChannelsModel: Codable{
    let channels:[Channels]
}

struct Channels : Codable {
    let title: String
    let description: String
    let dj: String
    let image: String
}
