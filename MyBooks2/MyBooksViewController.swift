//
//  MyBooksViewController.swift
//  MyBooks2
//
//  Created by Tsugumi on 2020/10/21.
//  Copyright © 2020 兼崎亜深. All rights reserved.
//

import UIKit

var myBooks: [Book] = []
var booksByStatus: [Book] = []

class MyBooksViewController: UIViewController {
    
    let statusList = ["全て", "読みたい", "読んだ", "読んでる"]
    var segmentedControl: UISegmentedControl!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "ライブラリ"
        navigationController?.navigationBar.isTranslucent = false
        
        setSegmentedControl()
//        setSampleBooks()
        setCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didChangeOrientation(_:)),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        segmentChanged(segmentedControl)
    }
    
    
    //MARK: Set up
    
    private func setSegmentedControl() {
        
        segmentedControl = UISegmentedControl(items: statusList)
        segmentedControl.frame.size = CGSize(
            width: view.frame.width - 80,
            height: 35
        )
        segmentedControl.center = CGPoint(
            x: view.center.x,
            y: 35
        )
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(segmentedControl)
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = self.view.bounds.width / 3 - 40
        let height: CGFloat = width / 0.6
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: layout
        )
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    @objc private func didChangeOrientation(_ notification: Notification) {
        collectionView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        collectionView.setNeedsDisplay()
        collectionView.reloadData()
    }
    
    private func setSampleBooks() {
        var imageLink: URL
        var imageData: UIImage?
        imageLink = URL(string: "http://books.google.com/books/content?id=s3C7DgAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api")!
        if let imageD = try? Data(contentsOf: imageLink) {
            imageData = UIImage(data: imageD)
        } else {
            imageData = UIImage(named: "noImage")
        }
        
        let book = Book(title: "君の膵臓を食べたい", authors: "住野よる", image: imageData!, publisher: "双葉社", publishedDate: "2019-04-14", printType: "book", pageCount: 283, language: "JP", explanation: "ある日、高校生の僕は病院で一冊の文庫本を拾う。タイトルは「共病文庫」。それは、クラスメイトである山内桜良が密かに綴っていた日記帳だった。そこには、彼女の余命が膵臓の病気により、もういくばくもないと書かれていて——。読後、きっとこのタイトルに涙する。デビュー作にして2016年本屋大賞・堂々の第2位、75万部突破のベストセラー待望の文庫化！")
        
        for _ in 0..<10 {
            myBooks += [book!]
        }
    }
    
    
    //MARK: Actions
    
    @objc func segmentChanged(_ segment: UISegmentedControl) {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        let segmentTitle = segmentedControl.titleForSegment(at: selectedIndex)
        
        switch segmentTitle {
        case "全て":
            booksByStatus = myBooks
        case "読みたい":
            booksByStatus = myBooks.filter { $0.status == "読みたい"}
        case "読んだ":
            booksByStatus = myBooks.filter { $0.status == "読んだ"}
        case "読んでる":
            booksByStatus = myBooks.filter { $0.status == "読んでる"}
        default:
            break
        }
        
        self.collectionView.reloadData()
    }
}


//MARK: UICollectionViewDataSource

extension MyBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksByStatus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let book = booksByStatus[indexPath.row]
        
        cell.imageView.image = book.image
        
        return cell
    }
}
