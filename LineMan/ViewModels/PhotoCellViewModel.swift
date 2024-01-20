//
//  PhotoCellViewModel.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//

import Foundation

class PhotoCellViewModel {
    private let photo: Photo

    init(photo: Photo) {
        self.photo = photo
    }

    var name: String {
        return photo.name
    }

    var description: String {
        return photo.description
    }

    var likeCount: String {
        return "\(photo.positiveVotesCount)"
    }

    var imageURLs: [String] {
   
        return photo.imageURL
    }
    
    
}


