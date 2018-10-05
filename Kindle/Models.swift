//
//  Models.swift
//  KindleClone
//
//  Created by Tien Tran on 10/3/18.
//  Copyright © 2018 Tien-Enterprise. All rights reserved.
//

import UIKit
class Book {
	let title: String
	let author: String
	let pages: [Page]
	let coverImageUrl: String
	
	
	init(dictionary: [String: Any]) {
		self.title = dictionary["title"] as? String ?? ""
		self.author = dictionary["author"] as? String ?? ""
		self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
		
		var bookPages = [Page]()
		if let pagesDictionaries = dictionary["pages"] as? [[String:Any]] {
			
			for pageDictionary in pagesDictionaries {
				if let pageText = pageDictionary["text"] as? String {
					let page = Page(number: 0, text: pageText)
					bookPages.append(page)
				}
				
			}
		}
		pages = bookPages
	}
}

class Page {
	let number: Int
	let text: String
	
	init(number: Int, text: String) {
		self.number = number
		self.text = text
	}
}
