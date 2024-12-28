//
//  BaseServiceComb.swift
//  APIRestCombine
//
//  Created by Javier Calatrava on 16/12/24.
//

import Foundation
import Combine

final class BaseServiceComb<T: Decodable> {

    let decoder = JSONDecoder()
    
    var forcedErrorApi: ErrorService? = nil
    var forcedResposeApi: T? = nil
    var param = ""
    
    init(param: String) {
        self.param = param
    }
    
    // MARK: - Open
    func getPathParam() -> String {
        return param
    }
    
    func setforcedErrorApi(_ error: ErrorService) {
        forcedErrorApi = error
    }
    
    func setforcedResposeApi(_ response: T) {
        forcedResposeApi = response
    }
    
    // MARK: - APIManagerProtocol
    // Publisher que devuelve un array de CharacterJson
    func fetch() -> AnyPublisher<T, Error> {
        guard let url = BaseServiceComb<T>.createURLFromParameters(parameters: [:], pathparam: getPathParam()) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchFut() -> Future<T, Error> {
        return Future { ( promise: @escaping (Result<T, Error>) -> Void) in
            nonisolated(unsafe) let promise = promise

                guard let url = BaseServiceComb<T>.createURLFromParameters(parameters: [:], pathparam: self.getPathParam())else {
                    return promise(.failure(URLError(.badURL)))
                }

                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    Task { @MainActor in
                        guard let httpResponse = response as? HTTPURLResponse,
                              (200...299).contains(httpResponse.statusCode) else {
                            promise(.failure(ErrorService.invalidHTTPResponse))
                            return
                        }
                        
                        guard let data = data else {
                            promise(.failure(URLError(.badServerResponse)))
                            return
                        }
                        
                        do {
                            let dataParsed: T = try JSONDecoder().decode(T.self, from: data)
                            promise(.success(dataParsed))
                        } catch {
                            promise(.failure(ErrorService.failedOnParsingJSON))
                            return
                        }
                    }
                }
                task.resume()
        }
    }


    
    
    
    // MARK: - Internal / private
    
    private static func createURLFromParameters(parameters: [String: Any], pathparam: String?) -> URL? {
        
        let apiScheme = "https"
        let host = "rickandmortyapi.com"
        let path = "/api/"
        
        var components = URLComponents()
        components.scheme = apiScheme
        components.host = host
        components.path = path
        if let paramPath = pathparam {
            components.path = path + "\(paramPath)"
        }
        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                guard var queryItems = components.queryItems else { return nil }
                queryItems.append(queryItem)
            }
        }
        
        return components.url
    }
}

typealias Completion<T> = @Sendable (Result<T, Error>) -> Void


struct Promise<T: Sendable> {
    private let executor: (@escaping Completion<T>) -> Void
    
    init( executor: @escaping (@escaping Completion<T>) -> Void) {
        self.executor = executor
    }
    
    func resolve(completion: @escaping Completion<T>) {
        executor(completion)
    }
}

