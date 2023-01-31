//
//  Model.swift
//  Chuckapi
//
//  Created by Kostiantyn Kaniuka on 31.01.2023.
//

import Foundation

struct Joke: Codable, Identifiable {
    var id: String
    var value: String
    var icon_url: String
}
