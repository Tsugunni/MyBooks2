//
//  SearchedBooksTableViewController.swift
//  MyBooks2
//
//  Created by Tsugumi on 2020/07/13.
//  Copyright © 2020 兼崎亜深. All rights reserved.
//

import UIKit

class SearchedBooksTableViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate {

    
    //MARK: Properties
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchedBooks = [Book]()
    let numOfGetBooks = 10
    
    struct ResultJson: Codable {
        let items: [ItemJson]?
    }
    
    struct ItemJson: Codable {
        let volumeInfo: VolumeInfoJson
    }
    
    struct VolumeInfoJson: Codable {
        let title: String?
        let authors: [String]?
        let imageLinks: ImageLinkJson?
        let publisher: String?
        let publishedDate: String?
        let printType: String?
        let pageCount: Int?
        let language: String?
        let description: String?
    }
    
    struct ImageLinkJson: Codable {
        let thumbnail: URL?
        let small: URL?
        let medium: URL?
        let large: URL?
        let smallThumbnail: URL?
        let extraLarge: URL?
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "検索"
        self.navigationController?.delegate = self
        
        setSearchBar()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    //MARK: Setup
    
    private func setTableView() {
        tableView = UITableView()
        tableView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.maxX,
            height: self.view.frame.maxY
        )
        tableView.rowHeight = 100
        tableView.register(SearchedBooksTableViewCell.self, forCellReuseIdentifier: "SearchedBooksTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    private func setSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "タイトル・著者名で探す"
            searchBar.tintColor = UIColor.gray
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
        }
    }
    
    
    //MARK: Search Books
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        if let searchWord = searchBar.text {
            searchBooks(keyword: searchWord)
        }
    }
    
    func searchBooks(keyword: String) {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        // create request URL
        guard let req_url = URL(string: "https://www.googleapis.com/books/v1/volumes?maxResults=\(numOfGetBooks)&q=\(keyword_encode)") else {
            return
        }
        
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            session.finishTasksAndInvalidate()
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                self.searchedBooks.removeAll()
                
                if let items = json.items {
                    for item in items {
                        
                        var imageLink: URL?
                        if let imageLinks = item.volumeInfo.imageLinks {
                            if let mediumImage = imageLinks.medium {
                                imageLink = mediumImage
                            }
                            else if let smallImage = imageLinks.small{
                                imageLink = smallImage
                            }
                            else if let largeImage = imageLinks.large {
                                imageLink = largeImage
                            }
                            else if let extraLargeImage = imageLinks.extraLarge {
                                imageLink = extraLargeImage
                            }
                            else if let thumbnailImage = imageLinks.thumbnail {
                                imageLink = thumbnailImage
                            }
                            else if let smallThumbnailImage = imageLinks.smallThumbnail {
                                imageLink = smallThumbnailImage
                            } else {
                                return
                            }
                        }
                        
                        var imageData: UIImage!
                        if let imageLink = imageLink {
                            if let imageD = try? Data(contentsOf: imageLink) {
                                imageData = UIImage(data: imageD)
                            } else {
                                fatalError("Failed to change the data")
                            }
                        } else {
                            imageData = UIImage(named: "NoImage")
                        }
                        
                        var authors: String = ""
                        if let authorsList = item.volumeInfo.authors {
                            for (i, author) in authorsList.enumerated() {
                                if i > 0 {
                                    authors += ", "
                                }
                                authors += author
                            }
                        }

                        let book = Book(title: item.volumeInfo.title, authors: authors, image: imageData, publisher: item.volumeInfo.publisher, publishedDate: item.volumeInfo.publishedDate, printType: item.volumeInfo.printType, pageCount: item.volumeInfo.pageCount, language: item.volumeInfo.language, explanation: item.volumeInfo.description)
                        
                        if let book = book {
                            self.searchedBooks.append(book)
                        } else {
                            print("book is nil")
                        }
                    }
                    self.tableView.reloadData()
                }
            } catch {
                print("error")
                print(error)
            }
        })
        task.resume()
    }
}


//MARK: UITableDateSource

extension SearchedBooksTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchedBooksTableViewCell(style: .default, reuseIdentifier: "SearchedBooksTableViewCell")
        
        let book = searchedBooks[indexPath.row]
        
        cell.bookImageView.image = book.image
        cell.titleLabel.text = book.title
        cell.authorsLabel.text = book.authors
        
        return cell
    }
}


//MARK: UISearchBarDelegate

extension SearchedBooksTableViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
