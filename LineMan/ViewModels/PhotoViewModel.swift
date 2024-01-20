//
//  PhotoViewModel.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//

import Foundation

class PhotosViewModel {

    private var photos: [Photo] = []

    // Completion handler to notify when data is fetched
    var onDataFetched: (() -> Void)?

    // Fetches photo data from the API
    func fetchPhotos() {
        if !(photos.isEmpty){
            print(photos.count)
            print("Remove old data -> Will resfesh")
            photos.removeAll()
            print(photos.count)
        }
        
        APICaller.shared.getPhotoDataCollection { [weak self] result in DispatchQueue.main.async {
                switch result {
                case Result.success(let photoModel):
                    self?.photos = photoModel.photos
                    self?.onDataFetched?() // Notify the view controller that data is fetched
                case Result.failure(let error):
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


