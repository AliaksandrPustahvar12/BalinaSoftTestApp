//
//  MainController.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 22.09.23.
//

import Foundation

protocol MainControllerProtocol {
    func getPhotos(for page: Int) async
    func getImageData(url: String) async -> Data?
    func uploadPhoto(image: Data, id: Int)
    var photos: [PhotoTypeDtoOut.PhotoDtoOut] { get set }
    var page: Int { get set }
    var isPagOn: Bool { get set }
}

final class MainController: MainControllerProtocol {
    
    var photos: [PhotoTypeDtoOut.PhotoDtoOut] = []
    var page = 0
    var isPagOn: Bool = false
    
    private var maxPages: Int?
    private weak var view: MainViewProtocol?
    private let netService = NetworkService()
    
    private let host = "junior.balinasoft.com"
    private let path = "/api/v2/photo/type"
    private let pathToUpload = "/api/v2/photo"
    
    init(view: MainViewProtocol?) {
        self.view = view
        
        Task {
            await getPhotos(for: page)
        }
    }
    
    func getPhotos(for page: Int) async {
        isPagOn = true
        if maxPages == nil || page < maxPages! {
            let pageString = String(page)
            let queryItems: [URLQueryItem] = [.init(name: "page", value: pageString)]
            if let newPage: PhotoTypeDtoOut = await netService.fetchData(host: host, path: path, page: pageString, queryItems: queryItems) {
                photos.append(contentsOf: newPage.content)
                
                await MainActor.run {
                    self.view?.reloadTableView()
                }
                
                self.maxPages = newPage.totalPages
                self.page += 1
            }
        }
        isPagOn = false
    }
    
    func getImageData(url: String) async -> Data? {
        try? await netService.getImage(url: url)
    }
    
    func uploadPhoto(image: Data, id: Int) {
        let queryItems: [URLQueryItem] = [.init(name: "id", value: String(id))]
        let parameters: [String: Any] = [
            "name": "Pustahvar Aliaksandr",
            "photo": image,
            "typeId": String(id)
        ]
        netService.uploadPhotoToServer(host: host, path: pathToUpload, queryItems: queryItems, parameters: parameters)
    }
}
