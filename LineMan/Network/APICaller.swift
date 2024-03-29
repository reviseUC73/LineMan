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
    private let requestTimeoutInterval: TimeInterval = 30  

    // Completin 1 para function -> return void and para of parameter function is Result<PhotoModel, APIError>
    func getPhotoDataCollection(completion: @escaping (Result<PhotoModel, APIError>) -> Void) {
        
        guard let url = URL(string: "\(NetworkConstants.baseURL)") else {return}
        
        // Create a URLSessionConfiguration with a custom timeout interval
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = requestTimeoutInterval
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url) { data, response, error  in
            if error != nil {
                print("1")
                completion(Result.failure(APIError.canNotParseData))
                return
            }
            guard let data = data else {
                print("2")
                completion(Result.failure(APIError.failedToGetData))
                return
            }
            do {
                let photoModel = try JSONDecoder().decode(PhotoModel.self, from: data)
                print("API is Called")
                print("Number of data",photoModel.photos.count)
                completion(Result.success(photoModel))
            } catch {
                print("3")
                completion(Result.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
}
