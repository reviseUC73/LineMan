//
//  PhotoTableViewCells.swift
//  LineMan
//
//  Created by ReviseUC73 on 20/1/2567 BE.
//

import UIKit

class PhotoTableViewCells: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionLabel.sizeToFit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "PhotoTableViewCells"
    
        private let likeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "like")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
       let photoImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
       
       let nameLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 16)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       let descriptionLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14)
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       let likeCountLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
//           setupViews()
           setupViews2()
           setupConstraints()
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func setupViews() {
           contentView.addSubview(photoImageView)
           contentView.addSubview(nameLabel)
           contentView.addSubview(descriptionLabel)
           contentView.addSubview(likeCountLabel)
       }
       
    func configure(with viewModel: PhotoCellViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        likeCountLabel.text = viewModel.likeCount
        if let imageUrlString = viewModel.imageURLs.first, let imageUrl = URL(string: imageUrlString) {
            photoImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            photoImageView.image = UIImage(named: "placeholder")
        }
    }
    

    private func setupViews2() {
        nameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0

        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likeImageView)
        contentView.addSubview(likeCountLabel)
    }
    
    private func setupConstraints() {
        // Image view constraints
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoImageView.widthAnchor.constraint(equalToConstant: 80), // Assuming a square image
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor)
        ])
        
        // Title label constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
        
        // Description label constraints
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
    }
}
