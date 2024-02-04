//
//  PhotoModel.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//

import Foundation

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let currentPage: Int
    let totalPages: Int
    let totalItems: Int
    let feature: String
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case totalItems = "total_items"
        case feature
        case photos
    }
}

// MARK: - Photo
struct Photo: Codable {
    let name: String
    let description: String
    let positiveVotesCount: Int
    let imageURL: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case imageURL = "image_url"
        case positiveVotesCount = "positive_votes_count"
    }
}
