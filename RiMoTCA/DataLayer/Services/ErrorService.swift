//
//  ErrorAPI.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

enum ErrorService: Error {
    case errorResponse(Error)
    case invalidHTTPResponse
    case failedOnParsingJSON
    case noDataResponse
    case failedParallelFetching
    case fetchStopsFailed
    case badFormedURL
}

