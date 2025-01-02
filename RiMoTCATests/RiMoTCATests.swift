//
//  RiMoTCATests.swift
//  RiMoTCATests
//
//  Created by Javier Calatrava on 28/12/24.
//

import ComposableArchitecture
import Testing
import Foundation

@testable import RiMoTCA

struct RiMoTCATests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let store = await TestStore(initialState: CharatersFeature.State()) {
            CharatersFeature()
        }
        
        await store.send(.fetchCharacters) {
          $0.isLoading = true
        }
        
        await store.receive(\.fetchCharactersSuccess, timeout: .seconds(1)) {
          $0.isLoading = false
            $0.characters = expCharacters
        }
        
        await store.finish()
    }

    let expCharacters: [Character] =     [
        Character(
          name: "Rick Sanchez",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
          status: "Alive",
          species: "Human",
          location: "Citadel of Ricks",
          type: "",
          numberOfEpisodes: 51
        ),
        Character(
          name: "Morty Smith",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
          status: "Alive",
          species: "Human",
          location: "Citadel of Ricks",
          type: "",
          numberOfEpisodes: 51
        ),
        Character(
          name: "Summer Smith",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
          status: "Alive",
          species: "Human",
          location: "Earth (Replacement Dimension)",
          type: "",
          numberOfEpisodes: 42
        ),
        Character(
          name: "Beth Smith",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
          status: "Alive",
          species: "Human",
          location: "Earth (Replacement Dimension)",
          type: "",
          numberOfEpisodes: 42
        ),
        Character(
          name: "Jerry Smith",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
          status: "Alive",
          species: "Human",
          location: "Earth (Replacement Dimension)",
          type: "",
          numberOfEpisodes: 39
        ),
        Character(
          name: "Abadango Cluster Princess",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/6.jpeg",
          status: "Alive",
          species: "Alien",
          location: "Abadango",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Abradolf Lincler",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
          status: "unknown",
          species: "Human",
          location: "Testicle Monster Dimension",
          type: "Genetic experiment",
          numberOfEpisodes: 2
        ),
        Character(
          name: "Adjudicator Rick",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
          status: "Dead",
          species: "Human",
          location: "Citadel of Ricks",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Agency Director",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
          status: "Dead",
          species: "Human",
          location: "Earth (Replacement Dimension)",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Alan Rails",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/10.jpeg",
          status: "Dead",
          species: "Human",
          location: "Worldender\'s lair",
          type: "Superhuman (Ghost trains summoner)",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Albert Einstein",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/11.jpeg",
          status: "Dead",
          species: "Human",
          location: "Earth (Replacement Dimension)",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Alexander",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/12.jpeg",
          status: "Dead",
          species: "Human",
          location: "Anatomy Park",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Alien Googah",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/13.jpeg",
          status: "unknown",
          species: "Alien",
          location: "Earth (Replacement Dimension)",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Alien Morty",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/14.jpeg",
          status: "unknown",
          species: "Alien",
          location: "Citadel of Ricks",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Alien Rick",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/15.jpeg",
          status: "unknown",
          species: "Alien",
          location: "Citadel of Ricks",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Amish Cyborg",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/16.jpeg",
          status: "Dead",
          species: "Alien",
          location: "Earth (Replacement Dimension)",
          type: "Parasite",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Annie",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/17.jpeg",
          status: "Alive",
          species: "Human",
          location: "Anatomy Park",
          type: "",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Antenna Morty",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/18.jpeg",
          status: "Alive",
          species: "Human",
          location: "Citadel of Ricks",
          type: "Human with antennae",
          numberOfEpisodes: 2
        ),
        Character(
          name: "Antenna Rick",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/19.jpeg",
          status: "unknown",
          species: "Human",
          location: "unknown",
          type: "Human with antennae",
          numberOfEpisodes: 1
        ),
        Character(
          name: "Ants in my Eyes Johnson",
          imageUrl: "https://rickandmortyapi.com/api/character/avatar/20.jpeg",
          status: "unknown",
          species: "Human",
          location: "Interdimensional Cable",
          type: "Human with ants in his eyes",
          numberOfEpisodes: 1
        )
      ]
}
