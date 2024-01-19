//
//  PhotoViewModel.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//

import Foundation

class PhotosViewModel {

    private var photos: [Photo] = [] // Array to store the fetched photos

    // Completion handler to notify when data is fetched
    var onDataFetched: (() -> Void)?

    // Fetches photo data from the API
    func fetchPhotos() {
        APICaller.shared.getPhotoDataCollection { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoModel):
//                    print("photoModel.photos :",photoModel.photos)
                    self?.photos = photoModel.photos
                    self?.onDataFetched?() // Notify the view controller that data is fetched
                    
                case .failure(let error):
                    print("Error fetching photos: \(error.localizedDescription)")
                }
            }
        }
    }

    // Number of photos fetched
    var numberOfPhotos: Int {
        return photos.count
    }

    // Get a specific photo for a given index
    func photo(at index: Int) -> Photo? {
        guard index < photos.count else { return nil }
        return photos[index]
    }
}

