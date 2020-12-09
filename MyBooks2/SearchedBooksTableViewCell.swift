//
//  SearchedBooksTableViewCell.swift
//  MyBooks2
//
//  Created by Tsugumi on 2020/07/13.
//  Copyright © 2020 兼崎亜深. All rights reserved.
//

import UIKit

class SearchedBooksTableViewCell: UITableViewCell {
    
    var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(18)
        label.numberOfLines = 2
        return label
    }()
    
    var authorsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        return button
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bookImageView)
        NSLayoutConstraint.activate([
            bookImageView.widthAnchor.constraint(equalToConstant: 70),
            bookImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12.0),
            bookImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            bookImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        ])
        
        contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0),
            addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24.0),
            addButton.widthAnchor.constraint(equalToConstant: 24.0)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 12.0),
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: addButton.leftAnchor, constant: -12.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0)
        ])
        
        contentView.addSubview(authorsLabel)
        NSLayoutConstraint.activate([
            authorsLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 10.0),
            authorsLabel.rightAnchor.constraint(lessThanOrEqualTo: addButton.leftAnchor, constant: -12.0),
            authorsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
