//
//  MyBooksViewController.swift
//  MyBooks2
//
//  Created by Tsugumi on 2020/07/26.
//  Copyright © 2020 兼崎亜深. All rights reserved.
//

import UIKit

var myBooks: [Book] = []

class MyBooksCollectionViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        createSampleBooks()
        // Do any additional setup after loading the view.
    }
    
    
    func createSampleBooks() {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
