//
//  CollectionViewCell.swift
//  MyBooks2
//
//  Created by Tsugumi on 2020/10/23.
//  Copyright © 2020 兼崎亜深. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    override init(frame: CGRect) {
        imageView = .init(frame: .zero)
        super.init(frame: frame)
        configureImageView()
    }
    
    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
