//
//  MainTabBarController.swift
//  MyBooks2
//
//  Created by Tsugumi on 2020/07/26.
//  Copyright © 2020 兼崎亜深. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewControllers: [UIViewController] = []
        
        let myBooksVC = MyBooksViewController()
        let bookIcon = UIImage(systemName: "book")
        myBooksVC.tabBarItem = UITabBarItem(title: "ライブラリ", image: bookIcon, tag: 1)
        viewControllers.append(UINavigationController(rootViewController: myBooksVC))
        
        let searchedBooksTableVC = SearchedBooksTableViewController()
        let searchIcon = UIImage(systemName: "magnifyingglass")
        searchedBooksTableVC.tabBarItem = UITabBarItem(title: "検索", image: searchIcon, tag: 2)
        viewControllers.append(UINavigationController(rootViewController: searchedBooksTableVC))
        
        self.setViewControllers(viewControllers, animated: false)
        self.selectedIndex = 0
    }
}
