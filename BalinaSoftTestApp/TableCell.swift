//
//  TableCell.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 22.09.23.
//

import UIKit

class TableCell: UITableViewCell {
    
    static let identifier = "Cell"

     let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         imageView.layer.cornerRadius = 8
       // imageView.image = UIImage(systemName: "circle")
        return imageView
    }()
    
     let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        //label.text = "Some text"
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
