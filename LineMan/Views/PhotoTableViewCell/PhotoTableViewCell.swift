//
//  PhotoTableViewCell.swift
//  LineMan
//
//  Created by ReviseUC73 on 18/1/2567 BE.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel: PhotoCellViewModel) {
        print("MARK : viewModel.imageURLs",viewModel.imageURLs)
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        likeCountLabel.text = viewModel.likeCount
        if let urlString = viewModel.imageURLs.first, let url = URL(string: urlString) {
            photoImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            photoImage.image = UIImage(named: "placeholder") // Default image if no URL is available
        }}}
     
    

    

