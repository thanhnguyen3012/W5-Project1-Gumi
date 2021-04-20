//
//  HomeViewModel.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 19/04/2021.
//

import UIKit

protocol HomeViewModelEvents: class {
    func reloadCollection()
}

class HomeViewModel {
    weak var delegate: HomeViewModelEvents?
    
    init(delegate: HomeViewModelEvents?) {
        self.delegate = delegate
    }
    
    let originalListOfItem = [Item(image: UIImage(named: "img_blue-berry")!, name: "Blue berry", price: 9.6, rating: 3.4, description: "There is description of blueberry.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_papaya")!, name: "Papaya", price: 6.8, rating: 6.8, description: "There is description of papaya.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_avocado")!, name: "Avocado", price: 11.7, rating: 7.2, description: "There is description of avocado.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_banana")!, name: "Banana", price: 15.4, rating: 6.3, description: "There is description of banana.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_raspberry")!, name: "Raspberry", price: 7.15, rating: 8.3, description: "There is description of raspberry.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_pineapple")!, name: "Pineapple", price: 7.4, rating: 8.8, description: "There is description of pineapple.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_cherry")!, name: "Cherry", price: 7.8, rating: 5.5, description: "There is description of cherry.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_strawberry")!, name: "Strawberry", price: 15.75, rating: 7.7, description: "There is description of strawberry.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_coconut")!, name: "Coconut", price: 8.9, rating: 3.7, description: "There is description of coconut.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_melon")!, name: "Melon", price: 4.2, rating: 5.7, description: "There is description of melon.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_lemon")!, name: "Lemon", price: 1.0, rating: 2.9, description: "There is description of melon.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_apple")!, name: "Apple", price: 13.6, rating: 8.7, description: "There is description of apple.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_tangerine")!, name: "Tangerine", price: 10.4, rating: 4.9, description: "There is description of tangerine.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"]),
                            Item(image: UIImage(named: "img_pomegranate")!, name: "Pomegranate", price: 3.4, rating: 2.1, description: "There is description of pomegranate.", nutrition: ["Vitamin C", "Vitamin A", "Mineral", "Fiber"])]
    
    var listOfItem = [Item]()
    
    func search(keyWord: String) {
        
        listOfItem.removeAll()
        for item in originalListOfItem {
            if item.name.uppercased().contains(keyWord.uppercased()) {
                listOfItem.append(item)
            }
        }
        delegate?.reloadCollection()
    }
    
    func showOriginalList() {
        listOfItem = originalListOfItem
        delegate?.reloadCollection()
    }
    
    func changeLoveStateAt(_ index: Int?){
        if let i = index,  i < listOfItem.count {
            listOfItem[i].isLoved = !listOfItem[i].isLoved
        }
    }
}
