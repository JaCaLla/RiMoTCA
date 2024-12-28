//
//  Character.swift
//  RiMoTCA
//
//  Created by Javier Calatrava on 27/12/24.
//

import Foundation

struct Character: Hashable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let imageUrl: String
    let status: String
    let species: String
    let location: String
    let type: String
    let numberOfEpisodes: Int
}

extension Character: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.status == rhs.status &&
        lhs.species == rhs.species &&
        lhs.location == rhs.location &&
        lhs.type == rhs.type &&
        lhs.numberOfEpisodes == rhs.numberOfEpisodes 
    }
}

extension Character {
    init(_ characterJson: CharacterJson) {
        self.name = characterJson.name
        self.imageUrl = characterJson.image
        self.status = characterJson.status
        self.species = characterJson.species
        self.location = characterJson.location.name
        self.type = characterJson.type
        self.numberOfEpisodes = characterJson.episode.count
    }
}

extension Character {
    static let sample = Character(name: "name",
                                  imageUrl: "i",
                                  status: "s",
                                  species: "sp",
                                  location: "l",
                                  type: "t",
                                  numberOfEpisodes: 66)
    static let sampleMorty = Character(name: "Morty Smith",
                                  imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                                  status: "Alive",
                                  species: "Human",
                                  location: "Citadel of Ricks",
                                  type: "",
                                  numberOfEpisodes: 51)
}
