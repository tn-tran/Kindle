//
//  BookPageController.swift
//  KindleClone
//
//  Created by Tien Tran on 10/4/18.
//  Copyright © 2018 Tien-Enterprise. All rights reserved.
//

import Foundation
import UIKit
class BookPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
	
	var book: Book?
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.backgroundColor = .white
		navigationItem.title = self.book?.title
		
		collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
		
		let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
		layout?.scrollDirection = .horizontal
		layout?.minimumLineSpacing = 0
		
		collectionView.isPagingEnabled = true
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleCloseBook))
	}
	
	@objc func handleCloseBook() {
		dismiss(animated: true, completion: nil)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return book?.pages.count ?? 0 
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
		let page = book?.pages[indexPath.item]
		pageCell.textLabel.text = page?.text
		return pageCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: view.frame.height - 44 - 20)
	}
	
	
}
