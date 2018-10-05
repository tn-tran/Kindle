//
//  BookCell.swift
//  KindleClone
//
//  Created by Tien Tran on 10/3/18.
//  Copyright © 2018 Tien-Enterprise. All rights reserved.
//

import Foundation
import UIKit

class BookCell: UITableViewCell {
	
	var book: Book? {
		didSet {
			
			titleLabel.text = book?.title
			authorLabel.text = book?.author
			guard let coverImageUrl = book?.coverImageUrl else { return }
			guard let url = URL(string: coverImageUrl) else { return }
			coverImageView.image = nil
			URLSession.shared.dataTask(with: url) { (data, response, error) in
				
				
				if let err = error {
					print("Failed to retrieve our book cover image, ", err)
				}
				
				guard let imageData = data else { return }
				let image = UIImage(data: imageData)
				DispatchQueue.main.async {
					self.coverImageView.image = image
				}
				
			}.resume()
		}
	}
	private let coverImageView: UIImageView = {
		let imageView = UIImageView()
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "steve_jobs")

		return imageView
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "This is the text of the title fo the book"
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	private let authorLabel: UILabel =  {
		let label = UILabel()
		label.text = "This is the author label for the row"
		label.textColor = .gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		
		backgroundColor = .clear
		addSubview(coverImageView)
		coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
		coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
		coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
		coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
		
		addSubview(titleLabel)
		titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: 20)
		titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
		titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true

		
		addSubview(authorLabel)
		authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
		authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
		authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
		authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
