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
        setupTableView()
        
//        setUpTableViews()
        tableView.estimatedRowHeight = 100 // Or whatever your estimated height is
        tableView.rowHeight = UITableView.automaticDimension
        fetchPhotoData() // Call -> pass nil
        
        
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
            fetchPhotoData {
                sender.endRefreshing() // Call -> pass completion closure
            }
        }
    
    private func fetchPhotoData(completion: (() -> Void)? = nil) {
        viewModel.fetchPhotos()
        viewModel.onDataFetched = { [weak self] in
            self?.tableView.reloadData()
            completion?()
        }
    }
    
        // MARK: - SETUP TABLE
        func setupTableView() {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
            self.tableView.refreshControl = refreshControl
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.backgroundColor = .systemBackground
            self.registerCells()}
    
//    private func setUpTableViews() {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
//        self.tableView.refreshControl = refreshControl
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.tableView.backgroundColor = .systemBackground
//        self.tableView.register(PhotoTableViewCells.self, forCellReuseIdentifier: PhotoTableViewCells.identifier)}
    
    
}


//// MARK: - UITableViewDataSource
//extension MainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfPhotos
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCells.identifier, for: indexPath) as? PhotoTableViewCells,
//              let photo = viewModel.photo(at: indexPath.row) else {
//            fatalError("Could not dequeue PhotoTableViewCell")
//        }
//        
//        let cellViewModel = PhotoCellViewModel(photo: photo)
//        cell.configure(with : cellViewModel)
//        return cell
//    }
//}
//
//// MARK: - UITableViewDelegate
//extension MainViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}


extension MainViewController: UITableViewDataSource , UITableViewDelegate {
    

    
    // Table -> Resgier Cell
    private func registerCells() {
        self.tableView.register(PhotoTableViewCell.registerCell(), forCellReuseIdentifier: PhotoTableViewCell.identifier)
    }
    
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
    // Table -> Delegate -> Deselect all row in table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           // Handle cell selection
       }
    
}



