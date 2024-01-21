//
//  ViewController.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewModels
    private var viewModel = PhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupTableView()
        fetchPhotoData()
    }
    
    // MARK: - SETUP TABLE
    func setupTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        self.tableView.backgroundColor = .systemBackground
        self.tableView.register( UINib(nibName: PhotoTableViewCell.identifier , bundle: nil), forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
    }
    
    private func fetchPhotoData(completion: (() -> Void)? = nil) {
        viewModel.fetchPhotos()
        viewModel.onDataFetched = { [weak self] in
            self?.tableView.reloadData()
            completion?()
        }
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
            fetchPhotoData {
                sender.endRefreshing()
            }
        }
}


extension MainViewController: UITableViewDataSource , UITableViewDelegate {
    
    // Table -> NumberOfRow
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos
    }
    
    // Table -> Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell,
              let photo = viewModel.photo(at: indexPath.row) else {
            return UITableViewCell()
        }
        let cellViewModel = PhotoCellViewModel(photo: photo)
        cell.configure(viewModel: cellViewModel)
     
        return cell
    }
    
    // Table -> Define deselect all row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
}



