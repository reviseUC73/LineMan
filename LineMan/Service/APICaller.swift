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

// Singleton Design Patter
class APICaller {
    
    static let shared = APICaller()
    
    func getPhotoDataCollection(completion: @escaping (Result<PhotoModel, APIError>) -> Void) {
        // Check URL
        guard let url = URL(string: "\(NetworkConstants.baseURL)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Check error
            if error != nil {
                completion(.failure(APIError.canNotParseData))
                return
            }
            
            // Check data
            guard let data = data else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                // Success
                let photoModel = try JSONDecoder().decode(PhotoModel.self, from: data)
                completion(.success(photoModel))
                
            } catch {
                // Error
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
}
