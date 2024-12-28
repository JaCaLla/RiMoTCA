//
//  CharacterService.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//
//@MainActor
@globalActor
actor GlobalManager {
    static var shared = GlobalManager()
}

@GlobalManager
final class CharacterService {

    let baseService = BaseService<ResponseJson<CharacterJson>>(param: "character")
    
    init() {
    }
    
    func fetch() async -> Result<ResponseJson<CharacterJson>, ErrorService> {
        await baseService.fetch()
    }
}
