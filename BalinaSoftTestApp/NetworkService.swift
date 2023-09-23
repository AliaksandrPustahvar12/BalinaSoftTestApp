//
//  NetworkService.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 23.09.23.
//

import Foundation
import Alamofire

class NetworkService {
    
    func fetchData(path: String, page: String) async -> PhotoTypeDtoOut? {
        let urlComponents = getUrlComponents(path: path, page: page)
        do {
            return try await AF.request(urlComponents).serializingDecodable(PhotoTypeDtoOut.self,
                                                                            decoder: JSONDecoder()).value
        } catch {
            return nil
        }
    }
    
    func getImage(url: String) async throws -> Data? {
        guard let url = URL(string: url) else {
            throw MyErrors.badUrl
        }
        let response = try await URLSession.shared.data(from: url)
        let data = response.0
        return data
    }
    
    func getUrlComponents(path: String, page: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "junior.balinasoft.com"
        urlComponents.path = path
        urlComponents.queryItems = [.init(name: "page", value: page)]
        return urlComponents
    }
    
    enum MyErrors: Error {
        case badUrl
    }
}
