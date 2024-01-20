//
//  APICaller.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//


import Foundation

// Error case (enum)
enum APIError: Error {
    case urlError
    case canNotParseData
    case failedToGetData

}

// Singleton
class APICaller {
    
    static let shared = APICaller()
    
    func getPhotoDataCollection(completion: @escaping (Result<PhotoModel, APIError>) -> Void) {
        
        guard let url = URL(string: "\(NetworkConstants.baseURL)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(Result.failure(APIError.canNotParseData))
                return
            }
            guard let data = data else {
                completion(Result.failure(APIError.failedToGetData))
                return
            }
            do {
                let photoModel = try JSONDecoder().decode(PhotoModel.self, from: data)
                print(photoModel.photos.count)
                print("API is Called")
                completion(Result.success(photoModel)
                )
            } catch {
                completion(Result.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
}
