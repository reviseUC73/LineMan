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
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        anotherSetupElement()
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
    
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        // Reset the state of your cell here
//        nameLabel.text = nil
//        descriptionLabel.text = nil
//        likeCountLabel.text = nil
//        photoImage.image = nil
//    }
    
    
    private func anotherSetupElement(){
//        descriptionLabel.numberOfLines = 0 // This allows for multiline text
//        likeCountLabel.numberOfLines = 1
        
//        descriptionLabel.lineBreakMode = .byWordWrapping
//        descriptionLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
//        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .vertical)
    }
    
    
    
    
    
}
     
    

    

