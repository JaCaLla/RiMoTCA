//
//  DataManager.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//
@MainActor
protocol DataManagerProtocol: Sendable {
    func fetchCharacters(_ characterService: CharacterService?) async -> Result<[Character], Error>
}
@MainActor
internal final class DataManager: DataManagerProtocol, Sendable {

    func fetchCharacters(_ characterService: CharacterService? = nil) async -> Result<[Character], Error> {
        var service = characterService
        if service == nil {
            service = await CharacterService()
        }
        guard let service else { return .success([]) }
        let result = await service.fetch()
        switch result {
        case .success(let responseApiCharacterApi):
            let characters = responseApiCharacterApi.results.map { Character($0) }
            return .success(characters)
        case .failure (let error):
            return .failure(error)
        }
    }
}
