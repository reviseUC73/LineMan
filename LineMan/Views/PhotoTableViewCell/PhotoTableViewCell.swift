//
//  PhotoTableViewCell.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    
    // MARK: - Static Varibale
    static var identifier = "PhotoTableViewCell"
    static var loadImageNameIdentify = "placeholder"
    
    // MARK: - Static Function
    static func registerCell() -> UINib {
        UINib(nibName: PhotoTableViewCell.identifier , bundle: nil)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - SETUP PhotoCellViewModel
    func configure(viewModel: PhotoCellViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        likeCountLabel.text = viewModel.likeCount
        configurePhotoImage(viewModel)
    }
    
    fileprivate func configurePhotoImage(_ viewModel: PhotoCellViewModel) {
        if let urlString = viewModel.imageURLs.first {
            if let url = URL(string: urlString) {
                photoImage.sd_setImage(with: url, placeholderImage: UIImage(named: PhotoTableViewCell.loadImageNameIdentify ))
            }
        } else {
            photoImage.image = UIImage(named: PhotoTableViewCell.loadImageNameIdentify)
        }
    }
    
    
}
     
    

    

