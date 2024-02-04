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
        print("start 0.1 vm")
        if !(photos.isEmpty){
            photos.removeAll()
        }
        print("start 0.2 vm")
        APICaller.shared.getPhotoDataCollection() { [weak self] result in DispatchQueue.main.async {
            print("start 0.3 vm")
                switch result {
                case Result.success(let myPhotoModel):
                    print("start 1 vm")
                    self?.photos = myPhotoModel.photos
                    print("onF 2 vm")
                    self?.onDataFetched?() // Notify the view controller that data is fetched
                    print("end 3 vm")

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

    // Get specific photo for index
    func photo(at index: Int) -> Photo? {
        guard index < photos.count else { return nil } /// avoild index out of range
        return photos[index]
    }
}


