//
//  PageCell.swift
//  KindleClone
//
//  Created by Tien Tran on 10/4/18.
//  Copyright © 2018 Tien-Enterprise. All rights reserved.
//

import Foundation
import UIKit
class PageCell: UICollectionViewCell {
	let textLabel: UILabel = {
		let label = UILabel()
		label.text = "Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text "
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		
		addSubview(textLabel)
		
		textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
		textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
		textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
