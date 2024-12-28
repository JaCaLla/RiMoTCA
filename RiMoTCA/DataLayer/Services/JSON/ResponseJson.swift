//
//  ResponseAPI.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

struct ResponseJson<T: Codable>: Codable where T: Sendable {
    let info: InfoJson
    let results: [T]
}
