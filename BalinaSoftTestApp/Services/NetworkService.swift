//
//  NetworkService.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 23.09.23.
//

import Foundation
import Alamofire

final class NetworkService {
    
    func fetchData(host: String, path: String, page: String, queryItems: [URLQueryItem]) async -> PhotoTypeDtoOut? {
        let urlComponents = getUrlComponents(host: host, path: path, queryItems: queryItems)
        return try? await AF.request(urlComponents).serializingDecodable(PhotoTypeDtoOut.self).value
    }
    
    func getImage(url: String) async throws -> Data? {
        guard let url = URL(string: url) else {
            throw MyErrors.badUrl
        }
        let response = try await URLSession.shared.data(from: url)
        let data = response.0
        return data
    }
    
    func uploadPhotoToServer(host: String, path: String, queryItems: [URLQueryItem], parameters: [String: Any]) {
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = value as? Data {
                    multipartFormData.append(data, withName: key, fileName: "photo.jpg", mimeType: "image/jpeg")
                } else if let string = value as? String {
                    multipartFormData.append(string.data(using: .utf8)!, withName: key)
                }
            }
        }, to: getUrlComponents(host: host, path: path, queryItems: queryItems), method: .post).responseDecodable(of: PhotoUploadDtoOut.self ) { result in
            debugPrint(result)
        }
    }
    
    private func getUrlComponents(host: String, path: String, queryItems: [URLQueryItem]) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    enum MyErrors: Error {
        case badUrl
    }
}
