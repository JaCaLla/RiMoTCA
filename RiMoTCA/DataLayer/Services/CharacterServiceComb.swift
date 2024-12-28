//
//  CharacterServiceComb.swift
//  APIRestCombine
//
//  Created by Javier Calatrava on 16/12/24.
//

import Combine
import Foundation

final class CharacterServiceComb {

    let baseService = BaseServiceComb<ResponseJson<CharacterJson>>(param: "character")
    
    init() {
    }
    
    func fetch() -> AnyPublisher<ResponseJson<CharacterJson>, Error>  {
        baseService.fetch()
    }
    
    func fetchFut() -> Future<ResponseJson<CharacterJson>, Error> {
        baseService.fetchFut()
    }
}
