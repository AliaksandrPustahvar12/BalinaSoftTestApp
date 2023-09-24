//
//  TableCell.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 22.09.23.
//

import UIKit

final class TableCell: UITableViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.tintColor = .systemGray5
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpCell()
    }
    
    private func setUpCell() {
        
        self.contentView.backgroundColor = .systemGray6
        self.contentView.addSubview(cellImageView)
        self.contentView.addSubview(cellLabel)
        
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cellImageView.heightAnchor.constraint(equalToConstant: 70),
            cellImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        cellImageView.image = nil
    }
}
