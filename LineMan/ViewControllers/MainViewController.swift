//
//  ViewController.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel = PhotosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")

        fetchPhotoData()
    }

    private func fetchPhotoData() {
        viewModel.fetchPhotos()
        viewModel.onDataFetched = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        return UITableViewCell()
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell,
              let photo = viewModel.photo(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cellViewModel = PhotoCellViewModel(photo: photo)
        cell.configure(with: cellViewModel)
        
        // Load image if needed. You might need to use a library like SDWebImage to handle image loading and caching.
        
        return cell
        
        
    }
    
    
    
    
    
    
    
    //import UIKit
    //
    //class MainViewController: UIViewController {
    //
    //    @IBOutlet weak var tableView: UITableView!
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //
    //
    //
    //        APICaller.shared.getLineDataCollection{
    //            result in
    //            switch result {
    //            case .success(let photoModel):
    //                for photo in photoModel.photos {
    //                    print(photo)
    //                    print("Name: \(photo.name)")
    //                    print("Description: \(photo.description)")
    //                    print("Positive Votes Count: \(photo.positiveVotesCount)")
    //                    print("Image URL: \(photo.imageURL)")
    //                    print(type(of: photo.positiveVotesCount))
    //                }
    //
    //            case .failure(let error):
    //                print("Error: \(error.localizedDescription)")
    //
    //            }
    //        }
    //
    //
    //    }
    //}
}
