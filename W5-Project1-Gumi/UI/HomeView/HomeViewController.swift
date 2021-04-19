//
//  HomeViewController.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 12/04/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    
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
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "Fruits"
        
        listOfItem = originalListOfItem
        
        itemCollectionView.register(ItemCollectionViewCell.nib, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        if let layout = itemCollectionView.collectionViewLayout as? CustomCollectionViewFlowLayout {
            layout.delegate = self
        }
        
        searchBar.delegate = self
        searchBar.placeholder = "Search your fruits"
        let searchButton = UIBarButtonItem.init(image: UIImage.init(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(self.searchTouched(sender: )))
        searchButton.tag = 0 // 0: touch to turn to search mode.    1: Touch to cancel searchmode
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = UIColor(named: "label")
        
        
        self.itemCollectionView.keyboardDismissMode = .onDrag
    }
    
    @objc func searchTouched(sender: UIBarButtonItem) {
        if sender.tag == 0 {
            sender.image = nil
            sender.title = "Cancel"
            sender.tag = 1
            navigationItem.titleView = searchBar
            searchBar.sizeToFit()
        } else {
            listOfItem = originalListOfItem
            itemCollectionView.reloadData()
            sender.image = UIImage.init(systemName: "magnifyingglass")
            sender.title = nil
            sender.tag = 0
            searchBar.text = ""
            let titleLabel = UILabel()
            titleLabel.text = self.title
            titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            navigationItem.titleView = titleLabel
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        vc.bindData(item: listOfItem[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listOfItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        cell.setupView(item: listOfItem[indexPath.row])
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 45) / 2, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension HomeViewController: CustomCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
       let width = (collectionView.frame.width - 45) / 2
       return (listOfItem[indexPath.row].image.size.height / listOfItem[indexPath.row].image.size.width) * width + 122
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let key = searchBar.text ?? ""
        listOfItem.removeAll()
        for item in originalListOfItem {
            if item.name.uppercased().contains(key.uppercased()) {
                listOfItem.append(item)
            }
        }
        itemCollectionView.reloadData()
    }
}
