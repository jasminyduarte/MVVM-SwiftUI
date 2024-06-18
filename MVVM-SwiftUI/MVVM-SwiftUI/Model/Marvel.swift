//
//  Marvel.swift
//  MVVM-SwiftUI
//
//  Created by Jasminy Duarte on 18/06/24.
//

import Foundation

// MARK: - Marvel
struct Marvel: Identifiable, Decodable {
    let id: Int
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: DataClass
    let etag: String
}

// MARK: - Response
struct MarvelResponse: Decodable {
    let request: [Marvel]
}

// MARK: - DataClass
struct DataClass: Decodable {
    let offset, limit, total, count: String
    let results: [Results]
}

// MARK: - Result
struct Results: Decodable {
    let id, name, description, modified: String
    let resourceURI: String
    let urls: [URLElement]
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let events, series: Comics
}

// MARK: - Comics
struct Comics: Decodable {
    let available, returned, collectionURI: String
    let items: [ComicsItem]
}

// MARK: - ComicsItem
struct ComicsItem: Decodable {
    let resourceURI, name: String
}

// MARK: - Stories
struct Stories: Decodable {
    let available, returned, collectionURI: String
    let items: [StoriesItem]
}

// MARK: - StoriesItem
struct StoriesItem: Decodable {
    let resourceURI, name, type: String
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let path, thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Decodable {
    let type, url: String
}
