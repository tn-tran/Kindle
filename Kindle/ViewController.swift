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
		setupNavigationBarStyles()
		
		tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = UIColor.lightGray
		navigationController?.title = "Kindle"
		
		fetchBooks()

	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 50
	}
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footerView = UIView()
		footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
		let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
		segmentedControl.tintColor = .white
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		footerView.addSubview(segmentedControl)
		segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
		segmentedControl.centerXAnchor.constraint(equalTo:  footerView.centerXAnchor).isActive = true
		segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
		segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		let gridButton = UIButton(type: .system)
		gridButton.setImage(UIImage(named: "grid")?.withRenderingMode(.alwaysOriginal), for: .normal)
		gridButton.translatesAutoresizingMaskIntoConstraints = false
		footerView.addSubview(gridButton)
		gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
		gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
		gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
		gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
		
		let sortButton = UIButton(type: .system)
		sortButton.setImage(UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal), for: .normal)
		sortButton.translatesAutoresizingMaskIntoConstraints = false
		footerView.addSubview(sortButton)
		sortButton.rightAnchor.constraint(equalTo: footerView.leftAnchor, constant: -8).isActive = true
		sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
		sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
		sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
		return footerView
	}
	func fetchBooks() {
		
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
	func setupNavigationBarStyles() {
		navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 0)
		navigationController?.navigationBar.isTranslucent = false
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPressed))
			navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "amazon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAmazonIconPressed))
	}

	@objc func handleMenuPressed() {
		print("menu button pressed")
	}
	@objc func handleAmazonIconPressed() {
		print("amazon button pressed")
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

