//
//  ViewController.swift
//  KindleClone
//
//  Created by Tien Tran on 10/3/18.
//  Copyright © 2018 Tien-Enterprise. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
	var books: [Book]?


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
		tableView.tableFooterView = UIView()
		navigationController?.title = "Kindle"
		
		fetchBooks()

	}
	func fetchBooks() {
		print("Fetching books")
		if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
			URLSession.shared.dataTask(with: url) { (data, response, error) in
				
				if let err = error {
					print("failed to fetch external json books: ", err)
					return
				}
				guard let data = data else { return }
				do {
					let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
					guard let bookDictionaries = json as? [[String:Any]] else { return }
					self.books = []
					for bookDictionary in bookDictionaries {
						let book = Book(dictionary: bookDictionary)
						self.books?.append(book)
					}
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
					
				} catch let jsonError {
					print("fail to parse JSON properly", jsonError)
				}
			
			}.resume()
			
		}
	
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let book = self.books?[indexPath.row]
		
		
		let layout = UICollectionViewFlowLayout()
		let bookPageController = BookPageController(collectionViewLayout: layout)
		
		bookPageController.book = book
		
		let navController = UINavigationController(rootViewController: bookPageController)
		present(navController, animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 86
	}
	

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let count = books?.count {
			return count
		}
		return 0
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
		
		let book =  books?[indexPath.row]
		cell.book = book
		return cell
	}
	
}

