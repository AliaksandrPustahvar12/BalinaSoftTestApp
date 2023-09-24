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
    
    func uploadPhotoToServer(id: Int, path: String, parameters: [String: Any]) {
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = value as? Data {
                    multipartFormData.append(data, withName: key, fileName: "photo.jpg", mimeType: "image/jpeg")
                } else if let string = value as? String {
                    multipartFormData.append(string.data(using: .utf8)!, withName: key)
                }
            }
        }, to: uploadUrlComponents(path: path, id: id), method: .post) { result in
            print (result)
        }
    }
    
    func getUrlComponents(path: String, page: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "junior.balinasoft.com"
        urlComponents.path = path
        urlComponents.queryItems = [.init(name: "page", value: page)]
        return urlComponents
    }
    
    func uploadUrlComponents(path: String, id: Int) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "junior.balinasoft.com"
        urlComponents.path = path
        urlComponents.queryItems = [.init(name: "id", value: String(id))]
        return urlComponents

    }
    
    enum MyErrors: Error {
        case badUrl
    }
}
