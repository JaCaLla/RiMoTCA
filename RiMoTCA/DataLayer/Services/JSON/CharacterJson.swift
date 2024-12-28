//
//  CharacterAPI.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

struct CharacterJson: Codable, Sendable {
    let name: String
    let image: String
    let status: String
    let species: String
    let type: String
    let episode: [String]
    let location: LocationJson
}
