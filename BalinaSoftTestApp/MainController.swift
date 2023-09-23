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
    var photos: [PhotoTypeDtoOut.PhotoDtoOut] { get set }
    var page: Int { get set }
    var isPagOn: Bool { get set }
}

final class MainController: MainControllerProtocol {
    
    var photos: [PhotoTypeDtoOut.PhotoDtoOut] = []
    var page = 0
    var maxPages: Int?
    var isPagOn: Bool = false
    private weak var view: MainViewProtocol?
    private var netService = NetworkService()
    private var path = "/api/v2/photo/type"
    
    init(view: MainViewProtocol?) {
        self.view = view
        
        Task {
           await getPhotos(for: page)
                
                DispatchQueue.main.async {
//                    view?.spinner.stopAnimating()
                    view?.reloadTableView()
                }
        }
    }
    
    func getPhotos(for page: Int) async {
        isPagOn = true
        print( page )
        if maxPages == nil || page < maxPages ?? 0 {
            if let newPage: PhotoTypeDtoOut = await netService.fetchData(path: path, page: String(page)) {
                photos.append(contentsOf: newPage.content)
                print(photos.count)
                DispatchQueue.main.async {
                    self.view?.reloadTableView()
                }
                self.maxPages = newPage.totalPages
                self.page += 1
            }
        }
        isPagOn = false
    }
    
  func getImageData(url: String) async -> Data? {
            do {
                return try await netService.getImage(url: url)
            } catch {
                return nil
            }
        }
    }
