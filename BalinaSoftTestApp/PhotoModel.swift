//
//  PhotoModel.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 23.09.23.
//

import Foundation

struct PhotoTypeDtoOut: Decodable {
    let content: [PhotoDtoOut]
    let page: Int
    let totalPages: Int
    
    struct PhotoDtoOut: Decodable {
        let id: Int
        let name: String
        let image: String?
    }
}

