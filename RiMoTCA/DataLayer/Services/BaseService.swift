//
//  BaseService.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import Foundation

@GlobalManager
final class BaseService<T: Decodable> {
    private let apiScheme = "https"
    private let host = "rickandmortyapi.com"
    private let path = "/api/"
    private let decoder = JSONDecoder()
    
    var forcedErrorApi: ErrorService? = nil
    var forcedResposeApi: T? = nil
    var param = ""
    
    init(param: String) {
        self.param = param
    }
    
    // MARK: - Open
    
     func getPathParam() -> String {
       // fatalError("Has to be implemented by subclass")
        return param
    }
    
    func setforcedErrorApi(_ error: ErrorService) {
        forcedErrorApi = error
    }
    
    func setforcedResposeApi(_ response: T) {
        forcedResposeApi = response
    }
    
    // MARK: - APIManagerProtocol
    func fetch() async -> Result<T, ErrorService> {
        if let forcedErrorApi {
            return .failure(forcedErrorApi)
        }
        if let forcedResposeApi {
            return .success(forcedResposeApi)
        }
        guard let url = createURLFromParameters(parameters: [:], pathparam: getPathParam()) else {
            return .failure(.badFormedURL)
        }
        return await fetchAsync(url: url)
    }
    
    // MARK: - Internal / private
    fileprivate func fetchAsync(url: URL) async -> Result<T, ErrorService> {

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return .failure(ErrorService.invalidHTTPResponse)
            }
            do {
                let dataParsed: T = try self.decoder.decode(T.self, from: data)
                return .success(dataParsed)
            } catch {
                return .failure(ErrorService.failedOnParsingJSON)
            }
        } catch {
            return .failure(ErrorService.errorResponse(error))
        }
    }
    
    private func createURLFromParameters(parameters: [String: Any], pathparam: String?) -> URL? {

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
