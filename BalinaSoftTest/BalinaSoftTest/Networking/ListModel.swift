//
//  ListModel.swift
//  BalinaSoftTest
//
//  Created by Admin on 30.06.23.
//

import Foundation

struct ListModel: Codable {
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let totalElements: Int
    let content: [Content]
}

extension ListModel {
    
    struct Content: Codable {
        let id: Int
        let name: String
        let image: String?
    }
}
