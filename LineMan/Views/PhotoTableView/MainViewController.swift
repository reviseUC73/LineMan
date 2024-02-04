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
        fetchProcess()
    }
    
    // MARK: - SETUP TABLE
    func setupTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        self.tableView.backgroundColor = .systemBackground
        self.tableView.register( UINib(nibName: PhotoTableViewCell.identifier , bundle: nil), forCellReuseIdentifier: PhotoTableViewCell.identifier)
    }
    
    // MARK: Trailing Closures
    // fetchProcess -> use firstload viewDidload >>  completion is nil (case :  Nil)
    //                -> use when Refresh -> will call func refreshData -> func will call fetchProcess
    //                   by set completion = sender.endRefreshing() and use it (case : () -> Void)
    private func fetchProcess(completion: (() -> Void)? = nil) {
        print("1 v")
        viewModel.fetchPhotos()
        print("onF 2 v")
        viewModel.onDataFetched = { [weak self] in self?.tableView.reloadData(); print("2.5 v"); completion?() } /// set up function of viewModels
        print("end 3 v")
        
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        fetchProcess() { sender.endRefreshing() }                             // Tailing Closures
        
//        fetchProcess(completion:{ () -> Void in sender.endRefreshing() } )    // Normal Closures 1
//        fetchProcess(completion:{ sender.endRefreshing() } )                  // Normal Closures 2
//
//        fetchProcess(completion: senderEndRefreshing )                        // Call Function
//        func senderEndRefreshing() -> Void {
//            sender.endRefreshing()}
        
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



